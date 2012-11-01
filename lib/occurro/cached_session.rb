module Occurro
  module CachedSession

    def self.unique_visitor?(model, session)
      !(session[:occurro] && session[:occurro]["#{model.class.name}"] && session[:occurro]["#{model.class.name}"]["#{model.id}"])
    end

    def self.add_cache(model, session)
      session[:occurro] ||= {}
      session[:occurro]["#{model.class.name}"] ||= {}
      session[:occurro]["#{model.class.name}"]["#{model.id}"] = true
    end

  end
end
