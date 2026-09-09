require 'net/http'
require 'uri'
require 'json'
require 'base64'

class BoletaParserService
  def initialize(file_path, mime_type)
    @file_path = file_path
    @mime_type = mime_type
    @api_key = ENV['GEMINI_API_KEY'] 
  end
 
  def call
    file_data = Base64.strict_encode64(File.read(@file_path))

    # VOLVEMOS AL MODELO QUE SÍ TE FUNCIONABA: gemini-2.5-flash
    url = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=#{@api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    prompt = <<~TEXT
      Eres un experto contable en Chile. Analiza este documento (boleta o factura) y extrae los siguientes datos exactos.
      Devuelve ÚNICAMENTE un objeto JSON válido con estas llaves:
      - rut_emisor (string)
      - razon_social (string)
      - folio (string)
      - fecha_emision (formato YYYY-MM-DD)
      - monto_total (solo el número entero, sin signos)
      
      Si no logras encontrar un dato, asigna el valor null. No incluyas texto extra ni formato Markdown.
    TEXT

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = {
      contents: [{
        parts: [
          { text: prompt },
          { inline_data: { mime_type: @mime_type, data: file_data } }
        ]
      }],
      generationConfig: { response_mime_type: "application/json" }
    }.to_json

    response = http.request(request)
    result = JSON.parse(response.body)
    
    if result["error"]
      puts "======= ERROR DE GOOGLE GEMINI ======="
      puts result["error"]["message"]
      puts "======================================"
      return {}
    end
    
    raw_text = result.dig("candidates", 0, "content", "parts", 0, "text")
    
    if raw_text.nil?
      return {}
    end
    
    # LIMPIEZA CLAVE: Quitamos los bloques ```json ... ``` si Gemini los incluye
    cleaned_text = raw_text.gsub(/```json\s*/, "").gsub(/```\s*/, "").strip
    
    JSON.parse(cleaned_text)
  rescue => e
    puts "======= ERROR AL PARSEAR JSON ======="
    puts e.message
    puts "====================================="
    {}
  end
end