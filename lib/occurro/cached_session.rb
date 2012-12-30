module Occurro
  module CachedSession

    # Public: Checks if the given session already has a visit for
    # the given model. Retuns true or false.
    #
    def self.unique_visitor?(model, session)
      !(session[:occurro] && session[:occurro]["#{model.class.base_class.name}"] && session[:occurro]["#{model.class.base_class.name}"]["#{model.id}"])
    end

    # Public: Adds the given model to the given session.
    # Should be used once per unique_visitor.
    #
    def self.add_cache(model, session)
      session[:occurro] ||= {}
      session[:occurro]["#{model.class.base_class.name}"] ||= {}
      session[:occurro]["#{model.class.base_class.name}"]["#{model.id}"] = true
    end

  end
end
