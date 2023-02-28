class PeopleController < ApplicationController

  def show
    @person = Person.find(params[:id])
    authorize @person
  end
end
