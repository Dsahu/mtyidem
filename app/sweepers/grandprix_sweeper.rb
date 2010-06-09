class GrandprixSweeper < ActionController::Caching::Sweeper
  
  observe Grandprix
  
  def after_save(grandprix)
    expire_cache(grandprix)
  end
  
  def after_destroy(grandprix)
    expire_cache(grandprix)
  end
  
  def expire_cache(grandprix)
    expire_page :controller => :grandprixes, :action => :show, :id => grandprix.id
  end
end