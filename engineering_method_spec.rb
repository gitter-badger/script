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

describe EngineeringMethod do
  let(:description_msg) { "What is your clear and concise problem?" }
  let(:factors_msg) { "What are the important factors that affect this problem?" }
  let(:hypothesis_msg) { "What solution (model) do you propose? State any assumptions" }
  let(:expirements_msg) { "What expirements will you conduct?" }
  let(:observations_msg) { "How will you refine your model based on observations?" }
  let(:alterations_msg) { "How will you manipulate the model for a better solution?" }
  let(:confirmation_msg) { "How is your model efficient and effective?" }
  let(:conclusions_msg) { "What conclusions or recommendationts can you make?" }

  describe "walkthrough" do
    it "should ask for a clean and concise description of the problem space" do
      ## Mock expectation
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:description).and_return(description_msg)
      engineer.walkthrough
    end

    it "should ask for relevant factors" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:factors).and_return(factors_msg)
      engineer.walkthrough
    end

    it "should ask for a hypothetical solution (model) with assumptions" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:hypothesis).and_return(hypothesis_msg)
      engineer.walkthrough
    end

    it "should ask for expirements to validate model" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:expirements).and_return(expirements_msg)
      engineer.walkthrough
    end

    it "should ask for observations on experiment results" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:observations).and_return(observations_msg)
      engineer.walkthrough
    end

    it "should ask for any necessary model alterations" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:alterations).and_return(alterations_msg)
      engineer.walkthrough
    end

    it "should ask for expirement to confirm solution efficiency and effectiveness" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:confirmation).and_return(confirmation_msg)
      engineer.walkthrough
    end

    it "should ask for conclusions" do
      engineer = EngineeringMethod.new
      expect(engineer).to receive(:conclusions).and_return(conclusions_msg)
      engineer.walkthrough
    end
  end
end
