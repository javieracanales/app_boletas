class BoletasController < ApplicationController
  before_action :set_boletum, only: %i[ show edit update destroy ]

  # GET /boleta or /boleta.json
  def index
    @boleta = Boletum.all
  end

  # GET /boleta/1 or /boleta/1.json
  def show
  end

  # GET /boleta/new
  def new
    @boletum = Boletum.new
  end

  def upload
    # Solo muestra la vista para subir el archivo
  end

  def procesar
    if params[:documento].present?
      archivo = params[:documento]
      ruta = archivo.tempfile.path
      mime = archivo.content_type

      datos = BoletaParserService.new(ruta, mime).call

      @boletum = Boleta.new(
        rut_emisor: datos["rut_emisor"],
        razon_social: datos["razon_social"],
        folio: datos["folio"],
        fecha_emision: datos["fecha_emision"],
        monto_total: datos["monto_total"]
      )
      
      blob = ActiveStorage::Blob.create_and_upload!(
        io: archivo.tempfile,
        filename: archivo.original_filename,
        content_type: archivo.content_type
      )
      @boletum.documento.attach(blob)
      
      render :new, status: :unprocessable_entity
    else
      redirect_to upload_boletas_path, notice: "Por favor, sube un archivo."
    end
  end


  def edit
  end

def create
    @boletum = Boletum.new(boletum_params)

    respond_to do |format|
      if @boletum.save
        format.html { redirect_to boletas_path, notice: "Boleta creada exitosamente." }
        format.json { render :show, status: :created, location: @boletum }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @boletum.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /boleta/1 or /boleta/1.json
  def update
    respond_to do |format|
      if @boletum.update(boletum_params)
        format.html { redirect_to @boletum, notice: "Boletum was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @boletum }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @boletum.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /boleta/1 or /boleta/1.json
  def destroy
    @boletum.destroy!

    respond_to do |format|
      format.html { redirect_to boletas_path, notice: "Boletum was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boletum
      @boletum = Boletum.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def boletum_params
      params.expect(boleta: [ :rut_emisor, :razon_social, :folio, :fecha_emision, :monto_total ])
    end
end