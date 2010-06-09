class CalenderController < ApplicationController
  def index
    
    params.has_key?(:year) ? @year = params[:year].to_i : @year = Date.today.year
  	@events = Event.find(:all, :conditions => ["visible = true and year(events.when) = ?", @year], :order => 'events.when asc')
    
    @january = []
    @february = []
    @march = []
    @april = []
    @may = []
    @june = []
    @july = []
    @august = []
    @september = []
    @october = []
    @november = []
    @december = []
    
    @events.each do |event|
      
      case event.when.month
        when 1
          @january.push(event)
        when 2
          @february.push(event)
        when 3
          @march.push(event)
        when 4
          @april.push(event)
        when 5
          @may.push(event)
        when 6
          @june.push(event)
        when 7
          @july.push(event)
        when 8
          @august.push(event)
        when 9
          @september.push(event)
        when 10
          @october.push(event)
        when 11
          @november.push(event)
        when 12
          @december.push(event)
      end
      
    end
    
    
    
  end

end
