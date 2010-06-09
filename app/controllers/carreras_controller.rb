class CarrerasController < ApplicationController

  layout 'application'

  def index

    # INIT

    @today = Date.today
    if params[:year].to_s.to_i > 0
      @year = params[:year].to_i
    else
      @year = @today.year
    end
    
  	@coming_runs = Run.find(:all, :conditions => ["eventday >= ? and year(eventday) = ?", @today.to_s, @year], :order => "eventday desc")
    @past_runs = Run.find(:all, :conditions => ["eventday < ? and year(eventday) = ?", @today.to_s, @year], :order => "eventday desc")

   # COMING

    @cr_ar = []

    @coming_runs.each do |run|

      actual_month = run.eventday.month
      @cr_ar[actual_month] ||= [] # INIT if necesarry
      @cr_ar[actual_month] << run

    end


    # PAST

    @pr_ar = []

    @past_runs.each do |run|

      actual_month = run.eventday.month
      @pr_ar[actual_month] ||= [] # INIT if necesarry
      @pr_ar[actual_month] << run

    end


    # CLEAN UP

    @cr_ar.reverse!.compact!
    @pr_ar.reverse!.compact!


  end

  def show
  	@run = Run.find(params[:id])

  end
  

end
