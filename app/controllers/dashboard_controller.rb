class DashboardController < ApplicationController
  def index
  	election_date = Date.parse('2015-10-15')

  	@total_projects = Project.all.count
  	@total_federal_contributions = Project.all.sum(:federal_contribution)
  	@total_eligible_costs = Project.all.sum(:total_eligible_cost)


  	@projects_since_election = Project.where('approved_date > ?', election_date).count
  	@dollars_since_election = Project.where('approved_date > ?', election_date).sum(:federal_contribution)
    @dollar_comparison = @dollars_since_election - (@total_federal_contributions - @dollars_since_election)

    @eligible_since_election = Project.where('approved_date > ?', election_date).sum(:total_eligible_cost)


    @projects_one_year_ago = Project.where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).count.to_f
    @projects_two_years_ago = Project.where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).count.to_f

    @total_projects_year_over_year = ((@projects_one_year_ago - @projects_two_years_ago) / @projects_two_years_ago) * 100

    @project_dollars_one_year_ago = Project.where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).sum(:federal_contribution)
    @projects_dollars_two_years_ago = Project.where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).sum(:federal_contribution)

    @total_project_dollars_year_over_year = ((@project_dollars_one_year_ago - @projects_dollars_two_years_ago) / @projects_dollars_two_years_ago) * 100

    @eligible_dollars_one_year_ago = Project.where('approved_date > ?', Date.today.prev_year.beginning_of_year).where('approved_date < ?', Date.today.prev_year.end_of_year).sum(:total_eligible_cost)
    @eligible_dollars_two_years_ago = Project.where('approved_date > ?', Date.today.years_ago(2).beginning_of_year).where('approved_date < ?', Date.today.years_ago(2).end_of_year).sum(:total_eligible_cost)

    @total_eligible_year_over_year = ((@eligible_dollars_one_year_ago - @eligible_dollars_two_years_ago) / @eligible_dollars_two_years_ago) * 100


    @harper_projects = Project.where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).count
    @harper_dollars = Project.where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).sum(:federal_contribution)
    @harper_dollar_comparison = @dollars_since_election - @harper_dollars

    @harper_eligible_costs = Project.where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).sum(:total_eligible_cost)


    @average_project_cost = @dollars_since_election/@projects_since_election

    @median_project_cost = Project.where('approved_date > ?', "2006-02-06").where('approved_date < ?', election_date).median(:federal_contribution)
  end
end
