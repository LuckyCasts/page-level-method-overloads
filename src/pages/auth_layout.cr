abstract class AuthLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title

  needs current_user : User?

  # The default page title. It is passed to `Shared::LayoutHead`.
  #
  # Add a `page_title` method to pages to override it. You can also remove
  # This method so every page is required to have its own page title.
  def page_title
    "Welcome"
  end

  def render
    html_doctype

    html lang: "en" do
      m Shared::LayoutHead, page_title: page_title, context: context

      body do
        m Shared::FlashMessages, context.flash
        m Shared::Navbar, user: current_user

        main do
          div class: "max-w-7xl mx-auto py-6 sm:px-6 lg:px-8" do
            content
          end
        end
      end
    end
  end
end
