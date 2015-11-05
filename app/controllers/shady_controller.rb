class ShadyController < ApplicationController
  before_filter :authorize_global

  def create
    if pref[:shady].nil?
      pref[:shady] = true
      pref.save!
    end

    redirect_to :back
  end

  def destroy
    if pref[:shady]
      pref.others.delete(:shady)
      pref.save!
    end

    redirect_to :back
  end

  private

  def pref
    User.current.pref
  end
end
