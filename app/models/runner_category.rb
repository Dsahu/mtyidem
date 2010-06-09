class RunnerCategory < ActiveRecord::Base

  SEX_MODES = [[0,"Mujeres"], [1, "Hombres"], [2, "Mixto"]]
  belongs_to :run

  def name_with_color
    "#{name} - #{color}"
  end

  def sex_mode_name
    SEX_MODES[self.sex_mode].last
  end

end
