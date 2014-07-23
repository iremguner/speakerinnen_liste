module ArrayHelper
  def extract_ids_from_results(results)
    ids = []
    results.each { |result| ids << result.profile_id }
    return ids
  end

  def create_array_of_users(ids, options = { published: true, prefix: 'id', common_topic: nil })
    options[:published] = true if options[:published] == nil
    options[:prefix] = 'id' if options[:prefix] == nil

    users = []
    ids.each do |id|

      user = FactoryGirl.create(:published,
        email: "#{options[:prefix]}#{id}@example.com",
        firstname: "#{options[:prefix]}#{id}first name",
        lastname: "#{options[:prefix]}#{id}last name",
        published: options[:published]

      )
      if options[:common_topic] != nil
        user.topic_list = options[:common_topic]
      else
        user.topic_list = "#{options[:prefix]}#{id}topic"
      end

      user.translation.bio = "#{options[:prefix]}#{id} is interested in teaching #{options[:prefix]}#{id}-wanga"

      user.save!
      users << user
    end

    return users
  end
end
