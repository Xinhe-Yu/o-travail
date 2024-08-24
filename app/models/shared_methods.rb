module SharedMethods
  def date_cannot_be_too_late(field_name, ante_quem: Time.current, message: nil)
    value = send(field_name)
    errors.add(field_name, message || "can't after #{ante_quem}") if value > ante_quem
  end

  def date_cannot_be_too_early(field_name, post_quem: Time.current, message: nil)
    value = send(field_name)
    errors.add(field_name, message || "can't before #{post_quem}") if value < post_quem
  end

  def number_should_between(field_name, min: 0, max: 2, message: nil)
    value = send(field_name)
    return if value.nil? || (value.is_a?(Integer) && value.between?(min, max))

    errors.add(field_name, message || "must be an integer between #{min} and #{max}")
  end
end
