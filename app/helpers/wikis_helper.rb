module WikisHelper
  def active_view(bool)
    bool == @view ? 'active' : ''
  end
end
