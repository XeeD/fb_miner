module ApplicationHelper
  def link_to_add(model_or_title, path = nil)
    if model_or_title.is_a?(Symbol)
      model   = model_or_title.to_s.camelize.constantize
      title   = " New #{model.model_name.human.downcase}"
      path  ||= polymorphic_path(model, action: :new)
    else
      title = model_or_title
    end

    link_to path, class: %w(btn btn-success link_to_add) do
      html = icon("plus-sign")
      html << title
      html
    end
  end

  def link_to_show(path_or_model_instance, options = {})
    options.reverse_merge!(
        size: :small
    )

    link_to path_or_model_instance, class: %W(btn btn-info btn-#{options[:size]}) do
      html = icon("search")
      html
    end
  end

  def link_to_edit_with_title(model_instance, options = {})
    options.reverse_merge!(
        title: "Edit #{model_instance.class.model_name.human.downcase}",
        path: edit_polymorphic_path(model_instance)
    )

    link_to options[:path], class: %w(btn btn-info link_to_edit_with_title) do
      html = icon("edit")
      html << " "
      html << options[:title]
      html
    end
  end

  def link_to_edit(path_or_model_instance, options = {})
    options.reverse_merge!(
        size: :small,
        class: []
    )

    if path_or_model_instance.is_a?(ActiveRecord::Base)
      options[:path] ||= edit_polymorphic_path(path_or_model_instance)
    else
      options[:path] ||= path_or_model_instance
    end

    css_class = %W(btn btn-info btn-#{options[:size]}) + [*options[:class]]

    link_to options[:path], class: css_class do
      html = icon("edit")
      html
    end
  end

  def link_to_destroy(model_instance, options = {})
    options.reverse_merge!(
        confirm: "Are you sure to delete #{model_instance.class.model_name.human.downcase}?",
        size: :small,
        remote: false,
        path: polymorphic_path(model_instance)
    )

    btn_class = %W(btn btn-danger btn-#{options[:size]})

    link_to options[:path], class: btn_class, method: :delete, confirm: options[:confirm], remote: options[:remote] do
      html = icon("trash")
      html
    end
  end

  def link_to_back(title_or_model_instance, options = {})
    if title_or_model_instance.is_a?(ActiveRecord::Base)
      options[:path] ||= polymorphic_path(title_or_model_instance)
      title = "Back to #{title_or_model_instance.class.model_name.human.downcase}"
    else
      title = title_or_model_instance
    end

    link_to options[:path], class: %w(link_to_back btn btn-info btn-small) do
      html = icon("arrow-left")
      html << " "
      html << title
      html
    end
  end

  def icon(icon_name)
    content_tag :i, "", class: %W(icon-#{icon_name} icon-white)
  end
end
