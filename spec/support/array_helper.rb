module ArrayHelper
  def extract_ids_from_results(results)
    ids = []
    results.each { |result| ids << result.profile_id }
    return ids
  end

  def create_array_of_users(ids, published=true, prefix='id')
    users = []
    ids.each do |id|
      user = FactoryGirl.create(:published,
        email: "#{prefix}#{id}@example.com",
        firstname: "#{prefix}#{id}firstname",
        lastname: "#{prefix}#{id}lastname",
        published: published
      )
      user.save!
      users << user
    end

    return users
  end
end
