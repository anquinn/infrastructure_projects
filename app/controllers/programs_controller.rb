class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]

  # GET /programs
  # GET /programs.json
  def index
    @q = Program.ransack(params[:q])
    @q.sorts = 'title_en asc' if @q.sorts.empty?
    @programs = @q.result(distinct: true)
                .paginate(:page => params[:page], :per_page => 50)
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @projects = Project.where(program_id: @program.id).paginate(:page => params[:page], :per_page => 50)
    @total_federal_contributions = Project.where(program_id: @program.id).sum(:federal_contribution)
    @total_eligible_costs = Project.where(program_id: @program.id).sum(:total_eligible_cost)
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)

    respond_to do |format|
      if @program.save
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url, notice: 'Program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.fetch(:program, {})
    end
end
