class Manager::InstructionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @title = 'Instructions'
    @description = 'Sau usted que lo sae, y punto.'
  end
end
