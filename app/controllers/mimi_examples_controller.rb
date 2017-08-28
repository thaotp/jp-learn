class MimiExamplesController < ApplicationController
  before_action :set_mimi_example, only: [:show, :edit, :update, :destroy]
  layout 'simple'

  # GET /mimi_examples
  # GET /mimi_examples.json
  def index
    @mimi_examples = MimiExample.all.order(:position).page(params[:page])
    if params[:page].present?
      @mimi_examples = @mimi_examples
    end
    @mimi_examples = @mimi_examples
  end

  # GET /mimi_examples/1
  # GET /mimi_examples/1.json
  def show
  end

  # GET /mimi_examples/new
  def new
    @mimi_example = MimiExample.new
  end

  # GET /mimi_examples/1/edit
  def edit
  end

  # POST /mimi_examples
  # POST /mimi_examples.json
  def create
    @mimi_example = MimiExample.new(mimi_example_params)

    respond_to do |format|
      if @mimi_example.save
        format.html { redirect_to @mimi_example, notice: 'Mimi example was successfully created.' }
        format.json { render :show, status: :created, location: @mimi_example }
      else
        format.html { render :new }
        format.json { render json: @mimi_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mimi_examples/1
  # PATCH/PUT /mimi_examples/1.json
  def update
    respond_to do |format|
      if @mimi_example.update(mimi_example_params)
        format.html { redirect_to @mimi_example, notice: 'Mimi example was successfully updated.' }
        format.json { render :show, status: :ok, location: @mimi_example }
      else
        format.html { render :edit }
        format.json { render json: @mimi_example.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mimi_examples/1
  # DELETE /mimi_examples/1.json
  def destroy
    @mimi_example.destroy
    respond_to do |format|
      format.html { redirect_to mimi_examples_url, notice: 'Mimi example was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def match
    @mimi_example = MimiExample.find(params[:id])
    match = @mimi_example.example == params[:example]
    unless match
      @result = @mimi_example.example
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mimi_example
      @mimi_example = MimiExample.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mimi_example_params
      params.fetch(:mimi_example, {})
    end
end
