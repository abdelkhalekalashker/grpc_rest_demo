class CalculationsController < ActionController::API
  # GET /calculations
  def index
    @calculations = Calculation.all

    render json: @calculations
  end

  # POST /calculations
  def create
    # binding.irb 
    @calculation = Calculation.new(calculation_params)

    if @calculation.save
      render json: @calculation, status: :created, location: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calculations/:id
  def destroy
    Calculation.find(params[:id]).destroy
    head :no_content
  end

  private

  def calculation_params
    params.require(:calculation).permit(:result)
  end
end
