Occurro::Engine.routes.draw do
  get :increment, path: ':countable_type/:countable_id(.:format)', to: 'counters#increment'
end
