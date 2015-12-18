Rails.application.routes.draw do

  scope "/api/1" do
    resource :pings, only: [:create] do
      get 'hours' # param: origin
      get 'origins'
    end
  end

  root 'pings#transfer_chart'

end
