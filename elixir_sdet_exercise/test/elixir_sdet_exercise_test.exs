defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case

  # Start hound session and destroy when tests are run
  hound_session()


  #TODO function to take param to exclude and generate all form data except one field
  #def create_values(excluded) do
  #  elem_to_exclude = excluded
  #
  #end

  #Finding and storing necessary elements for tests to reduce redundancy
  def elem_names do
    first_name = find_element(:name, "firstname")
    last_name = find_element(:name, "lastname")
    user_email = find_element(:name, "reg_email__")
    confirm_email = find_element(:name, "reg_email_confirmation__")
    password = find_element(:name, "reg_passwd__")
    birth_month = find_element(:xpath, "//*[@id='month']/option[9]")
    birth_day = find_element(:xpath, "//*[@id='day']/option[32]")
    birth_year = find_element(:xpath, "//*[@id='year']/option[23]")
    gender_female = find_element(:xpath, "//input[@value='1']")
    gender_male = find_element(:xpath, "//input[@value='2']")
    gender_custom = find_element(:xpath, "//input[@value='-1']")
    sign_up_form_submit = find_element(:name, "websubmit")

    %{
      fname: first_name,
      lname: last_name,
      email: user_email,
      reenter_email: confirm_email,
      pw: password,
      birth_m: birth_month,
      birth_d: birth_day,
      birth_y: birth_year,
      gender_f: gender_female,
      gender_m: gender_male,
      gender_c: gender_custom,
      sign_up: sign_up_form_submit
    }

  end


  def sign_up_form_fail_assertion(test) do

    current_test = test

    expected_page_title = "Facebook - Log In or Sign Up"
    pass_test = if(page_title() == expected_page_title, do: :true, else: take_screenshot("./screenshots/#{current_test}_signup_test_fail.png"))
    assert pass_test == true

  end


  # Generate a fake email to reduce redundancy
  def generate_email do
    "#{Faker.Name.first_name()}#{Faker.Name.last_name()}@fake.com"
  end


  test "goes to facebook home page" do
    navigate_to "https://www.facebook.com"

    expected_page_title = "Facebook - Log In or Sign Up"
    pass_test = if(page_title() == expected_page_title, do: :true, else: take_screenshot("./screenshots/facebook_page_title_not_match.png"))
    assert pass_test == true

  end


  @tag :empty_values
  @tag :empty_first
  test "empty first name - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()

    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")
    click(elements[:birth_m])
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("empty_first_name")

    take_screenshot("./screenshots/val_empty_first_name.png")

  end



  @tag :empty_values
  @tag :empty_last
  test "empty last name - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()

    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")
    click(elements[:birth_m])
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("empty_last_name")

    take_screenshot("./screenshots/val_empty_last_name.png")

  end



  @tag :empty_values
  @tag :empty_email
  test "empty email - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()

    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:pw], "JJPa55w0rd!")
    click(elements[:birth_m])
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("empty_email")

    take_screenshot("./screenshots/val_empty_email.png")

  end



  @tag :empty_values
  @tag :empty_reenter_email
  test "empty reenter email - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()


    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")
    click(elements[:birth_m])
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("empty_reenter_email")

    take_screenshot("./screenshots/val_empty_reenter_email.png")

  end



  @tag :invalid_bd_select
  @tag :invalid_month
  test "invalid month - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()

    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")

    invalid_month = find_element(:xpath, "//*[@id='month']/option[1]")
    click(invalid_month)
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("invalid_month")

    take_screenshot("./screenshots/val_invalid_month.png")
  end



  @tag :invalid_bd_select
  @tag :invalid_day
  test "invalid day - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()

    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")

    click(elements[:birth_m])
    invalid_day = find_element(:xpath, "//*[@id='day']/option[1]")
    click(invalid_day)
    click(elements[:birth_y])
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("invalid_day")

    take_screenshot("./screenshots/val_invalid_day.png")

  end


  @tag :invalid_bd_select
  @tag :invalid_year
  test "invalid year - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()


    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")

    click(elements[:birth_m])
    click(elements[:birth_d])
    invalid_year = find_element(:xpath, "//*[@id='year']/option[1]")
    click(invalid_year)
    click(elements[:gender_m])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("invalid_year")

    take_screenshot("./screenshots/val_invalid_year.png")

  end




  @tag :no_gender_selection
  test "no gender selection - signup fail" do
    navigate_to "https://www.facebook.com"

    elements = elem_names()
    test_email = generate_email()

    input_into_field(elements[:fname], Faker.Name.first_name())
    input_into_field(elements[:lname], Faker.Name.last_name())
    input_into_field(elements[:email], "#{test_email}")
    input_into_field(elements[:reenter_email], "#{test_email}")
    input_into_field(elements[:pw], "JJPa55w0rd!")
    click(elements[:birth_m])
    click(elements[:birth_d])
    click(elements[:birth_y])
    click(elements[:sign_up])

    sign_up_form_fail_assertion("no_gender_selection")

    take_screenshot("./screenshots/val_no_gender_selection.png")

  end


  @tag :email_mismatch
  test "re-enter email doesn't match" do

   navigate_to "https://www.facebook.com"

   elements = elem_names()
   test_email = generate_email()
   bad_reenter_email = generate_email()

   input_into_field(elements[:fname], Faker.Name.first_name())
   input_into_field(elements[:lname], Faker.Name.last_name())
   input_into_field(elements[:email], "#{test_email}")
   input_into_field(elements[:reenter_email], "#{bad_reenter_email}")
   input_into_field(elements[:pw], "JJPa55w0rd!")
   click(elements[:birth_m])
   click(elements[:birth_d])
   click(elements[:birth_y])
   click(elements[:sign_up])

   sign_up_form_fail_assertion("reenter_email_no_match")

   take_screenshot("./screenshots/val_reenter_email_no_match.png")
  end


end
