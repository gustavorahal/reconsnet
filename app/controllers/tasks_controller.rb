
class TasksController < ApplicationController

  before_filter( :set_layout_vars )

  def set_layout_vars
    @no_left_panel = true
  end


  def index

  end

end