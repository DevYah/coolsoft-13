class SimilarityEngine

  WEIGHT = {jaccard: 0.5, k_shingles: 0.5}

  def self.calculate_jaccard_similarity(idea1, idea2)
    union = idea1.tag_ids | idea2.tag_ids
    inter = idea1.tag_ids & idea2.tag_ids
    Float(inter.size) / union.size
  end

  def self.recalculate_similarity(idea)
    # find ideas in tagged by the same tags
    ideas_in_tags = Idea.joins(:tags).where(tags: { id: idea.tags }).select('ideas.id').preload(:tags)

    similarities = []
    timestamp = Time.now.to_i
    timestamp = "#{timestamp},#{timestamp}"

    # calculate similarity with each idea
    ideas_in_tags.find_each do |similar_idea|
      jacc = calculate_jaccard_similarity(idea, similar_idea)
      similarity = WEIGHT[:jaccard] * jacc

      similarities.push("(#{idea.id},#{similarity},#{similar_idea.id},#{timestamp})," +
                        "(#{similar_idea.id},#{similarity},#{idea.id},#{timestamp})")
    end

    Similarity.where('idea_id = ? OR similar_idea_id = ?', idea.id, idea.id).delete_all

    if !similarities.empty?
      sql = "INSERT INTO similarities (`idea_id`, `similarity`, `similar_idea_id`, `created_at`, `updated_at`)" +
            " VALUES #{similarities.join(",")}"

      Similarity.connection.execute sql
    end
  end

end
