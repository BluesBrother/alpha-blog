
class ArticlesController < ApplicationController

  # When path articles/new is entered, the controller method "new" gets control. It creates a new Article object and assigns it to
  # the instance variable, @article. Then, by default, Rails will display a response view named, "new" (articles/new.html.erb).

  def new

    @article = Article.new # Create a new article and assign it to an instance variable, article

  end

  # When the user fills in the new article template and clicks Create Article, the controller method "create" receives
  # control (articles/create) with a hash called "params". The hash contains the input fields from the template, keyed
  # by field name (:title, :description). A new Article object is created and assigned to the instance variable @article.

  # The parameters used to initialize the new Article are extracted from the hash. Note that the parameters cannot be used
  # directly from the hash; first, they must be white-listed.

  # Finally, the new Article is saved to the database.

  # By default, when the create method exits, Ruby will attempt to render a view named, articles/create.html.erb, which
  # doesn't exist.

  def create

    #render plain: params[:article].inspect # Uncomment to display input parameters from web page

    #return # It is not an error to return early from a method

    @article = Article.new(article_params) # Create a new instance of Article initialized with values from the web form
    @article.save # Save the new article to the database
    redirect_to articles_show(@article) # Redirect to show with the new article to provide the response...

  end

  # This is a private (local) method used to "white-list" the parameters in the hash.

  private
  def article_params
    xyz = params.require(:article).permit(:title, :description)
    render plain: xyz
    puts xyz
    return xyz
  end



end