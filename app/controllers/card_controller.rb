# frozen_string_literal: true

class CardController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @cards = Card.all

    respond_to do |format|
      format.json { render json: @cards }
    end
  end
end