module PublicActivityHelper
  def exists_class?(c)
    if Object.const_get(c.to_sym).is_a?(Class)
      return true
    end
  rescue => error
    return false
  end

  def trackables
    all_trackables = PublicActivity::Activity.select(:trackable_type).group(:trackable_type).order(:trackable_type).map(&:trackable_type)
    existing_trackables = Array.new
    all_trackables.each {|t| existing_trackables << t if exists_class?(t) && !t.start_with?('Thing')}
    opt = Array.new
    existing_trackables.each do |t|
      opt << OpenStruct.new(id: t, name: t("activerecord.models.#{t.underscore}.one"))
    end
    opt
  end

  def keyables
    [[t('helpers.select.create'), 'create'], [t('helpers.select.update'), 'update'], [t('helpers.select.destroy'), 'destroy'], [t('helpers.select.inactivate'), 'inactivate']]
  end

  def trackable_label(activity, with_not_exists = true)
    label = activity.parameters[:model_label]
    if activity.trackable
      if can?(:read, activity.trackable)
        begin
          path = eval("#{activity.trackable_type.underscore}_path(activity.trackable)")
          Rails.application.routes.recognize_path(path, method: :get) # si no existe el route va al rescue y devuelve solo el label
          link_to label, activity.trackable
        rescue
          label
        end
      else
        label
      end
    else
      with_not_exists ? "#{label} <em>(ya no existe)</em>".html_safe : label
    end
  end

  def trackable_history(activity)
    "/public_activity?q[trackable_type_eq]=#{activity.trackable_type}&q[trackable_id_eq]=#{activity.trackable_id}"
  end

  def user_label(activity)
    if activity.owner
      if activity.owner_type == 'User' && can?(:read, activity.owner)
        link_to raw("<strong>#{activity.owner.try(:name)}</strong>"), activity.owner
      else
        "<strong>#{activity.owner.try(:name)}</strong>".html_safe
      end
    else
      'Usuario no existente'
    end
  end

  def owner_avatar(activity)
    if activity.owner
      image_tag attachment_url(activity.owner, :avatar, :fill, 32, 32, fallback: "avatars/male.png")
    else
      image_tag("avatars/male.png", width: 32, height: 32)
    end

  end
end