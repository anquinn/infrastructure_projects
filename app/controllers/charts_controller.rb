class ChartsController < ApplicationController
  def project_frequency
    render json: Project.where('approved_date > ?', "2015-10-15").group_by_month(:approved_date).count
  end

  def projects_by_region
    render json: Project.joins(:region).where('approved_date > ?', "2015-10-15").group("regions.code").count
  end

  def median_project_cost
    render json: Project.joins(:region).where('approved_date > ?', "2015-10-15").group("regions.code").median(:federal_contribution)
  end

  def total_spent_by_region
    render json: Project.joins(:region).where('approved_date > ?', "2015-10-15").group("regions.code").sum(:federal_contribution)
  end

  def dollars_spent_by_governments
    render json: Project.joins(:region).where('approved_date > ?', "2015-10-15").group("regions.code").sum(:federal_contribution)
  end

  def number_of_projects_by_governments
    render json: Project.joins(:region).where('approved_date > ?', "2015-10-15").group("regions.code").sum(:federal_contribution)
  end
end