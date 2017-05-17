module CollaboratorsHelper
  def checked(user)
    user.collaborators.each do |collaborator|
      if @collaborators.include?(collaborator)
        return true
      end
    end
    false
  end
end
