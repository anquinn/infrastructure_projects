class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @q = Location.ransack(params[:q])
    @q.sorts = 'name_en asc' if @q.sorts.empty?
    @locations = @q.result(distinct: true)
                .paginate(:page => params[:page], :per_page => 50)
  end

  def show
    election_date = Date.parse('2015-10-15')

    @projects = Project.where(location_id: @location.id).order(approved_date: :desc)

    #since 2002 totals
    @total_projects = Project.where(location_id: @location.id).count
    @total_federal_contributions = Project.where(location_id: @location.id).sum(:federal_contribution)
    @total_eligible_costs = Project.where(location_id: @location.id).sum(:total_eligible_cost)

    #since October 15 2015
    @projects_since_election = Project.where(location_id: @location.id).where('approved_date > ?', election_date).count
    @dollars_since_election = Project.where(location_id: @location.id).where('approved_date > ?', election_date).sum(:federal_contribution)
    @eligible_since_election = Project.where(location_id: @location.id).where('approved_date > ?', election_date).sum(:total_eligible_cost)
    
    #harper totals
    @harper_projects = Project.where(location_id: @location.id).where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).count
    @harper_dollars = Project.where(location_id: @location.id).where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).sum(:federal_contribution)
    @harper_eligible_costs = Project.where(location_id: @location.id).where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).sum(:total_eligible_cost)

    #calculations & comparisons
    @dollar_comparison = @dollars_since_election - (@total_federal_contributions - @dollars_since_election)
    @harper_dollar_comparison = @dollars_since_election - @harper_dollars

    
    @projects_one_year_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).count.to_f
    @projects_two_years_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).count.to_f

    @total_projects_year_over_year = ((@projects_one_year_ago - @projects_two_years_ago) / @projects_two_years_ago) * 100

    @project_dollars_one_year_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).sum(:federal_contribution)
    @projects_dollars_two_years_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).sum(:federal_contribution)

    @total_project_dollars_year_over_year = ((@project_dollars_one_year_ago - @projects_dollars_two_years_ago) / @projects_dollars_two_years_ago) * 100

    @eligible_dollars_one_year_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).sum(:total_eligible_cost)
    @eligible_dollars_two_years_ago = Project.where(location_id: @location.id).where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).sum(:total_eligible_cost)

    @total_eligible_year_over_year = ((@eligible_dollars_one_year_ago - @eligible_dollars_two_years_ago) / @eligible_dollars_two_years_ago) * 100

    @average_project_cost = @dollars_since_election/@projects_since_election
    if @average_project_cost.nan?
      @average_project_cost = 0;
    end

    @median_project_cost = Project.where(location_id: @location.id).where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).median(:federal_contribution)

    # driver_to_delete = @driver.first # you need the object that you want removed
    # @drivers.reject!{|driver| driver == driver_to_delete}

    @suggested_locations = Location.where("name_en like ?", "%#{@location.name_en}%").reject { |l| l == @location }
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.fetch(:location, {})
    end
end
