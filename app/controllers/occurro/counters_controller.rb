module Occurro
  class CountersController < ApplicationController
    respond_to :js

    def increment
      if Occurro::CachedSession.unique_visitor?(countable, session)
        countable.increment_counter
        Occurro::CachedSession.add_cache(countable, session)
      end
      render text: ""
    end

    private

    def countable
      @countable ||=
        params[:countable_type].constantize.find params[:countable_id]
    end

  end
end
