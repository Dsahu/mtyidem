class Run < ActiveRecord::Base
  has_many :runner_categories
  has_many :ins_stores
  belongs_to :runtype
  has_many :convocatoriaunits
  has_many :events
  has_many :videos
  has_many :pictures
  has_many :runevents
  has_many :payconds, :through => :runevents
  has_many :inscriptions
  has_one :diploma_schema
  
  DEFAULT_LOGO_PHOTO = "/images/runlogodefault.jpg"
  
  def visiblevideos
    Video.find(:all, :conditions => {:run_id => self.id, :visible => true}, :order => "name desc")
  end
  
  def self.all_with_open_inscription
    Run.find(:all, :conditions => ["inscriptionopen = true AND lastregisterday <= ?", Date.today])
  end
  
  def get_logo
    if self.logophoto
      self.logophoto
    else
      DEFAULT_LOGO_PHOTO
    end
  end
  
  def month_and_year
    "#{month_name(self.eventday.month)} #{self.eventday.year}"
  end

  def online_inscriptions
    Inscription.find(:all, :conditions => {:paidfrom_id => Inscription::ONLINE, :run_id => self.id})
  end

  def month_name(m=1)
    case m
      when 1
        "Enero"
      when 2
        "Febrero"
      when 3
        "Marzo"
      when 4
        "Abril"
      when 5
        "Mayo"
      when 6
        "Junio"
      when 7
        "Julio"
      when 8
        "Agosto"
      when 9
        "Septiembre"
      when 10
        "Octubre"
      when 11
        "Noviembre"
      when 12
        "Deciembre"
      else
        "NA"
    end
  end

  def after_inscription_check
    if last_ficha >= fichaend or lastregisterday == Date.today
      self.inscriptionopen = false
      self.save
    end
  end

end
