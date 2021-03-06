module ApplicationHelper

  def text_icon(icon, options={})
    capture_haml do
      haml_tag :i, class: "fa fa-#{icon.to_s.gsub('_','-')} #{options[:color]}"
      if options[:label]
        haml_tag :br
        haml_tag :span, options[:label]
      end
    end
  end

  def header(text, klass, options={})
    options[:element] ||= :h2
    options[:skip_button] ||= false
    capture_haml do
      haml_tag :div, class: 'row' do
        haml_tag :div, class: 'col-xs-6' do
          haml_tag options[:element] do
            haml_concat text_icon options[:icon] if options[:icon]
            haml_concat text
          end
        end
        haml_tag :div, class: 'col-xs-6 right' do
          unless options[:skip_button]
            if can?(:create, klass)
              haml_concat link_to("New #{klass.name.singularize}", new_polymorphic_url(klass.name.underscore.downcase.to_sym), class: 'btn btn-success')
            end
          end
          haml_concat options[:button] if options[:button]
        end
      end
      haml_tag :hr
    end
  end

  def show_header(text, object, options={})
    options[:element] ||= :h2
    options[:parent_object] ||= nil
    capture_haml do
      haml_tag :div, class: 'row' do
        haml_tag :div, class: 'col-xs-6' do
          haml_tag options[:element] do
            haml_concat text_icon options[:icon] if options[:icon]
            haml_concat text
          end
        end
        haml_tag :div, class: 'col-xs-6 right' do
          if action_name.eql? "show"
            if can?(:edit, object)
              if options[:parent_object]
                haml_concat link_to("Edit #{object.class.to_s.gsub(/([a-z])([A-Z])/, '\\1 \\2')}", edit_polymorphic_path([options[:parent_object],object]), class: 'btn btn-success')
              else
                haml_concat link_to("Edit #{object.class.to_s.gsub(/([a-z])([A-Z])/, '\\1 \\2')}", edit_polymorphic_path(object), class: 'btn btn-success')
              end
            end
          end
        end
      end
      haml_tag :hr
    end
  end

  def nav_button(link, text, options={})
    capture_haml do
      haml_tag :li do
        haml_tag :a, href: link, "data-no-turbolink" => options["data-no-turbolink"] do
          haml_concat text_icon options[:icon] if options[:icon]
          haml_concat "&nbsp; #{text}"
        end
      end
    end
  end

  def object_actions(*args)
    options = args.extract_options!
    object = args.shift
    acl_object = object.is_a?(Array) ? object.last : object
    html = []
    if args.any?
      args.each do |action|
        html << link_to(action.first, action.second)
      end
    end
    if can?(:read, acl_object) && !options[:skip_view]
      html << link_to(t('admin.show'), polymorphic_path(object))
    end
    if can?(:edit, acl_object) && !options[:skip_edit]
      edit_path = "edit_#{object.class.name.underscore}_path"
      html << link_to(t('admin.edit'), edit_polymorphic_path(object))
    end
    if can?(:destroy, acl_object) && !options[:skip_destroy]
      options[:confirm] ||= 'Are you sure? This action cannot be undone!'
      html << link_to(t('admin.destroy'), object, method: :delete, "data-confirm" => options[:confirm] )
    end
    html.join(' | ').html_safe
  end

  def errors_for(object)
    capture_haml do
      if object.errors.any?
        haml_tag :div, class: 'row' do
          haml_tag :div, class: 'twelve columns' do
            haml_tag :div, class: 'errors' do
              haml_tag :div, class: 'alert alert-danger' do
                object_name = t("models.#{object.class.name.underscore.downcase}", default: object.class.name.titleize)
                haml_tag :a, '&times;'.html_safe, class: 'close', "data-dismiss" => "alert", "aria-label" => "close"
                haml_tag :p, "#{pluralize(object.errors.count, 'error')} prohibited this #{object_name} from being saved"
                haml_tag :ul do
                  object.errors.full_messages.each do |error|
                    haml_tag :li, error
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  def display_flash
    capture_haml do
      flash.each do |type, message|
        message_class = case type
        when 'notice'
          'success'
        when 'alert'
          'warning'
        when 'error'
          'danger'
        else
          'info'
        end
        haml_tag :div, class: "alert alert-#{message_class} fade in" do
          haml_tag :a, '&times;'.html_safe, class: 'close', "data-dismiss" => "alert", "aria-label" => "close"
          haml_concat message
        end
      end
    end
  end

end
