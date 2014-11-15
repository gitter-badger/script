#!/usr/bin/ruby -w
# engineering_method.rb
# Author: Andy Bettisworth
# Description: Reference for the Engineering Method

class EngineeringMethod
  def walkthrough
    description
    factors
    hypothesis
    expirements
    observations
    alterations
    confirmation
    conclusions
  end

  private

  def description
    "What is your clear and concise problem?"
  end

  def factors
    "What are the important factors that affect this problem?"
  end

  def hypothesis
    "What solution (model) do you propose? State any assumptions"
  end

  def expirements
    "What expirements will you conduct?"
  end

  def observations
    "How will you refine your model based on observations?"
  end

  def alterations
    "How will you manipulate the model for a better solution?"
  end

  def confirmation
    "How is your model efficient and effective?"
  end

  def conclusions
    "What conclusions or recommendationts can you make?"
  end
end

if __FILE__ == $0
end
