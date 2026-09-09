Rails.application.routes.draw do
  resources :boletas do
    collection do
      get :upload     # Pantalla para subir el archivo
      post :procesar  # Acción que manda el archivo a Gemini
    end
  end
  
  # Hacemos que la página de inicio sea la lista de boletas
  root "boletas#index" 
end