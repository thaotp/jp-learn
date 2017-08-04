class RadicalsController < ApplicationController
  def index
    radicals = Radical.all
    render json: radicals
  end

  def update
    radical = Radical.find(params[:radical][:id])
    if radical.update(permit_params)
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  private

  def permit_params
    params.require(:radical).permit(:times)
  end

end
