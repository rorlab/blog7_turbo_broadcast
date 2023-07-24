module ApplicationHelper
  def turbo_frame_requested?
    request.headers['Turbo-Frame'].present?
  end
end
