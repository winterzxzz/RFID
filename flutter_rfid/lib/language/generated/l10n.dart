// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PeerKnit`
  String get app_name {
    return Intl.message(
      'PeerKnit',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get button_ok {
    return Intl.message(
      'Ok',
      name: 'button_ok',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get button_close {
    return Intl.message(
      'Close',
      name: 'button_close',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get button_cancel {
    return Intl.message(
      'Cancel',
      name: 'button_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get button_skip {
    return Intl.message(
      'Skip',
      name: 'button_skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get button_next {
    return Intl.message(
      'Next',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get button_logout {
    return Intl.message(
      'Logout',
      name: 'button_logout',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get button_save {
    return Intl.message(
      'Save',
      name: 'button_save',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_up_email {
    return Intl.message(
      'Email',
      name: 'sign_up_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_up_email_hint {
    return Intl.message(
      'Email',
      name: 'sign_up_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_up_password {
    return Intl.message(
      'Password',
      name: 'sign_up_password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_up_password_hint {
    return Intl.message(
      'Password',
      name: 'sign_up_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get sign_up_password_confirm {
    return Intl.message(
      'Confirm Password',
      name: 'sign_up_password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get sign_up_password_confirm_hint {
    return Intl.message(
      'Confirm Password',
      name: 'sign_up_password_confirm_hint',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get have_account_message_1 {
    return Intl.message(
      'Already have an account? ',
      name: 'have_account_message_1',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login`
  String get have_account_message_2 {
    return Intl.message(
      'Go to Login',
      name: 'have_account_message_2',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get button_register {
    return Intl.message(
      'Register',
      name: 'button_register',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_in_email {
    return Intl.message(
      'Email',
      name: 'sign_in_email',
      desc: '',
      args: [],
    );
  }

  /// `SchoolSnapchat`
  String get sign_in_email_hint {
    return Intl.message(
      'SchoolSnapchat',
      name: 'sign_in_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_in_password {
    return Intl.message(
      'Password',
      name: 'sign_in_password',
      desc: '',
      args: [],
    );
  }

  /// `●●●●●●`
  String get sign_in_password_hint {
    return Intl.message(
      '●●●●●●',
      name: 'sign_in_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password_message {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password_message',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get button_login {
    return Intl.message(
      'Login',
      name: 'button_login',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? `
  String get sign_up_message_1 {
    return Intl.message(
      'Don’t have an account? ',
      name: 'sign_up_message_1',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get sign_up_message_2 {
    return Intl.message(
      'Get Started',
      name: 'sign_up_message_2',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forgot_password_email {
    return Intl.message(
      'Email',
      name: 'forgot_password_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get forgot_password_email_hint {
    return Intl.message(
      'Email',
      name: 'forgot_password_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Send mail to reset password`
  String get button_forgot_password {
    return Intl.message(
      'Send mail to reset password',
      name: 'button_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Back to `
  String get back_to_login_message_1 {
    return Intl.message(
      'Back to ',
      name: 'back_to_login_message_1',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get back_to_login_message_2 {
    return Intl.message(
      'Login',
      name: 'back_to_login_message_2',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get reset_password_token {
    return Intl.message(
      'Token',
      name: 'reset_password_token',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get reset_password_token_hint {
    return Intl.message(
      'Token',
      name: 'reset_password_token_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get reset_password {
    return Intl.message(
      'Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get reset_password_hint {
    return Intl.message(
      'Password',
      name: 'reset_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get reset_password_confirm {
    return Intl.message(
      'Confirm New Password',
      name: 'reset_password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get reset_password_confirm_hint {
    return Intl.message(
      'Confirm New Password',
      name: 'reset_password_confirm_hint',
      desc: '',
      args: [],
    );
  }

  /// `Save Change`
  String get button_reset_password {
    return Intl.message(
      'Save Change',
      name: 'button_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get bottom_tab_search {
    return Intl.message(
      'Search',
      name: 'bottom_tab_search',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get bottom_tab_chat {
    return Intl.message(
      'Chats',
      name: 'bottom_tab_chat',
      desc: '',
      args: [],
    );
  }

  /// `My page`
  String get bottom_tab_my_page {
    return Intl.message(
      'My page',
      name: 'bottom_tab_my_page',
      desc: '',
      args: [],
    );
  }

  /// `My Page`
  String get my_page_title {
    return Intl.message(
      'My Page',
      name: 'my_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_tab {
    return Intl.message(
      'Profile',
      name: 'profile_tab',
      desc: '',
      args: [],
    );
  }

  /// `QR code`
  String get qr_tab {
    return Intl.message(
      'QR code',
      name: 'qr_tab',
      desc: '',
      args: [],
    );
  }

  /// `Update profile to start chat with your friend`
  String get update_profile_warn_message {
    return Intl.message(
      'Update profile to start chat with your friend',
      name: 'update_profile_warn_message',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get profile_full_name {
    return Intl.message(
      'Full Name',
      name: 'profile_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Joey Tribbiani`
  String get profile_full_name_hint {
    return Intl.message(
      'Joey Tribbiani',
      name: 'profile_full_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Nick name`
  String get profile_nick_name {
    return Intl.message(
      'Nick name',
      name: 'profile_nick_name',
      desc: '',
      args: [],
    );
  }

  /// `Joey123`
  String get profile_nick_name_hint {
    return Intl.message(
      'Joey123',
      name: 'profile_nick_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get profile_nationality {
    return Intl.message(
      'Nationality',
      name: 'profile_nationality',
      desc: '',
      args: [],
    );
  }

  /// `Input and select Nationality`
  String get profile_nationality_hint {
    return Intl.message(
      'Input and select Nationality',
      name: 'profile_nationality_hint',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get profile_age {
    return Intl.message(
      'Age',
      name: 'profile_age',
      desc: '',
      args: [],
    );
  }

  /// `Select age`
  String get profile_age_hint {
    return Intl.message(
      'Select age',
      name: 'profile_age_hint',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get profile_school {
    return Intl.message(
      'School',
      name: 'profile_school',
      desc: '',
      args: [],
    );
  }

  /// `Select school`
  String get profile_school_hint {
    return Intl.message(
      'Select school',
      name: 'profile_school_hint',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get profile_grade {
    return Intl.message(
      'Grade',
      name: 'profile_grade',
      desc: '',
      args: [],
    );
  }

  /// `Select grade`
  String get profile_grade_hint {
    return Intl.message(
      'Select grade',
      name: 'profile_grade_hint',
      desc: '',
      args: [],
    );
  }

  /// `Club`
  String get profile_club {
    return Intl.message(
      'Club',
      name: 'profile_club',
      desc: '',
      args: [],
    );
  }

  /// `Basket ball`
  String get profile_club_hint {
    return Intl.message(
      'Basket ball',
      name: 'profile_club_hint',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get profile_state {
    return Intl.message(
      'State',
      name: 'profile_state',
      desc: '',
      args: [],
    );
  }

  /// `Input and select state`
  String get profile_state_hint {
    return Intl.message(
      'Input and select state',
      name: 'profile_state_hint',
      desc: '',
      args: [],
    );
  }

  /// `Student card`
  String get profile_student_card {
    return Intl.message(
      'Student card',
      name: 'profile_student_card',
      desc: '',
      args: [],
    );
  }

  /// `Photo or Gallery`
  String get photo_from_gallery {
    return Intl.message(
      'Photo or Gallery',
      name: 'photo_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get photo_from_camera {
    return Intl.message(
      'Take a photo',
      name: 'photo_from_camera',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get menu_logout {
    return Intl.message(
      'Logout',
      name: 'menu_logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get menu_delete_account {
    return Intl.message(
      'Delete Account',
      name: 'menu_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout?`
  String get logout_message {
    return Intl.message(
      'Do you want to logout?',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete your account? After deleting, If you want to use service, you have to register account again.`
  String get delete_account_message {
    return Intl.message(
      'Do you want to delete your account? After deleting, If you want to use service, you have to register account again.',
      name: 'delete_account_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get button_delete {
    return Intl.message(
      'Delete',
      name: 'button_delete',
      desc: '',
      args: [],
    );
  }

  /// `Please input Email`
  String get empty_email_error {
    return Intl.message(
      'Please input Email',
      name: 'empty_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input password`
  String get empty_password_error {
    return Intl.message(
      'Please input password',
      name: 'empty_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input confirm password`
  String get empty_confirm_password_error {
    return Intl.message(
      'Please input confirm password',
      name: 'empty_confirm_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Email format is incorrect`
  String get invalid_email_error {
    return Intl.message(
      'Email format is incorrect',
      name: 'invalid_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Email does not exist`
  String get email_exist_error {
    return Intl.message(
      'Email does not exist',
      name: 'email_exist_error',
      desc: '',
      args: [],
    );
  }

  /// `Email has already taken`
  String get email_taken_error {
    return Intl.message(
      'Email has already taken',
      name: 'email_taken_error',
      desc: '',
      args: [],
    );
  }

  /// `Password must have 6-30 characters`
  String get password_length_error {
    return Intl.message(
      'Password must have 6-30 characters',
      name: 'password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password must have 6-30 characters`
  String get confirm_password_length_error {
    return Intl.message(
      'Confirm password must have 6-30 characters',
      name: 'confirm_password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Password must have text, number and special character`
  String get invalid_password_error {
    return Intl.message(
      'Password must have text, number and special character',
      name: 'invalid_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password must have text, number and special character`
  String get invalid_confirm_password_error {
    return Intl.message(
      'Confirm password must have text, number and special character',
      name: 'invalid_confirm_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password and password do not match`
  String get confirm_password_match_error {
    return Intl.message(
      'Confirm password and password do not match',
      name: 'confirm_password_match_error',
      desc: '',
      args: [],
    );
  }

  /// `Email is incorrect`
  String get incorrect_email_error {
    return Intl.message(
      'Email is incorrect',
      name: 'incorrect_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Password is incorrect`
  String get incorrect_password_error {
    return Intl.message(
      'Password is incorrect',
      name: 'incorrect_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Token is sent to your email, please check`
  String get token_send_message {
    return Intl.message(
      'Token is sent to your email, please check',
      name: 'token_send_message',
      desc: '',
      args: [],
    );
  }

  /// `Please input token`
  String get empty_token_error {
    return Intl.message(
      'Please input token',
      name: 'empty_token_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input new password`
  String get empty_new_password_error {
    return Intl.message(
      'Please input new password',
      name: 'empty_new_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input confirm new password`
  String get empty_confirm_new_password_error {
    return Intl.message(
      'Please input confirm new password',
      name: 'empty_confirm_new_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Token is incorrect`
  String get incorrect_token_error {
    return Intl.message(
      'Token is incorrect',
      name: 'incorrect_token_error',
      desc: '',
      args: [],
    );
  }

  /// `New password must have 6-30 characters`
  String get new_password_length_error {
    return Intl.message(
      'New password must have 6-30 characters',
      name: 'new_password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password must have 6-30 characters`
  String get confirm_new_password_length_error {
    return Intl.message(
      'Confirm new password must have 6-30 characters',
      name: 'confirm_new_password_length_error',
      desc: '',
      args: [],
    );
  }

  /// `New password must have text, number and special character`
  String get invalid_new_password_error {
    return Intl.message(
      'New password must have text, number and special character',
      name: 'invalid_new_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password must have text, number and special character`
  String get invalid_confirm_new_password_error {
    return Intl.message(
      'Confirm new password must have text, number and special character',
      name: 'invalid_confirm_new_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password and new password do not match`
  String get confirm_new_password_match_error {
    return Intl.message(
      'Confirm new password and new password do not match',
      name: 'confirm_new_password_match_error',
      desc: '',
      args: [],
    );
  }

  /// `Password changed`
  String get password_updated_message {
    return Intl.message(
      'Password changed',
      name: 'password_updated_message',
      desc: '',
      args: [],
    );
  }

  /// `Please select Avatar`
  String get empty_avatar_error {
    return Intl.message(
      'Please select Avatar',
      name: 'empty_avatar_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input Full name`
  String get empty_full_name_error {
    return Intl.message(
      'Please input Full name',
      name: 'empty_full_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Full name only has text and space characters`
  String get invalid_full_name_error {
    return Intl.message(
      'Full name only has text and space characters',
      name: 'invalid_full_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Full name must have 50 characters or less`
  String get full_name_length_error {
    return Intl.message(
      'Full name must have 50 characters or less',
      name: 'full_name_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input Nick name`
  String get empty_nick_name_error {
    return Intl.message(
      'Please input Nick name',
      name: 'empty_nick_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Nick name only has text, number, dot (.) and underscore(_) characters`
  String get invalid_nick_name_error {
    return Intl.message(
      'Nick name only has text, number, dot (.) and underscore(_) characters',
      name: 'invalid_nick_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Nick name must have 50 characters or less`
  String get nick_name_length_error {
    return Intl.message(
      'Nick name must have 50 characters or less',
      name: 'nick_name_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select Nationality`
  String get empty_nationality_error {
    return Intl.message(
      'Please select Nationality',
      name: 'empty_nationality_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select Age`
  String get empty_age_error {
    return Intl.message(
      'Please select Age',
      name: 'empty_age_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select School`
  String get empty_school_error {
    return Intl.message(
      'Please select School',
      name: 'empty_school_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select Grade`
  String get empty_grade_error {
    return Intl.message(
      'Please select Grade',
      name: 'empty_grade_error',
      desc: '',
      args: [],
    );
  }

  /// `Please input Club`
  String get empty_club_error {
    return Intl.message(
      'Please input Club',
      name: 'empty_club_error',
      desc: '',
      args: [],
    );
  }

  /// `Club only has text and number and space characters`
  String get invalid_club_error {
    return Intl.message(
      'Club only has text and number and space characters',
      name: 'invalid_club_error',
      desc: '',
      args: [],
    );
  }

  /// `Club must have 50 characters or less`
  String get club_length_error {
    return Intl.message(
      'Club must have 50 characters or less',
      name: 'club_length_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select State`
  String get empty_state_error {
    return Intl.message(
      'Please select State',
      name: 'empty_state_error',
      desc: '',
      args: [],
    );
  }

  /// `Please select Student card`
  String get empty_student_card_error {
    return Intl.message(
      'Please select Student card',
      name: 'empty_student_card_error',
      desc: '',
      args: [],
    );
  }

  /// `Profile is registered`
  String get profile_registered_message {
    return Intl.message(
      'Profile is registered',
      name: 'profile_registered_message',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get profile_saved {
    return Intl.message(
      'Saved',
      name: 'profile_saved',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_conversation_hint {
    return Intl.message(
      'Search',
      name: 'search_conversation_hint',
      desc: '',
      args: [],
    );
  }

  /// `Search friends`
  String get search_add_member_hint {
    return Intl.message(
      'Search friends',
      name: 'search_add_member_hint',
      desc: '',
      args: [],
    );
  }

  /// `No user found`
  String get no_user_found_title {
    return Intl.message(
      'No user found',
      name: 'no_user_found_title',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data_title {
    return Intl.message(
      'No data',
      name: 'no_data_title',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get sender_name_title {
    return Intl.message(
      'You',
      name: 'sender_name_title',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats_title {
    return Intl.message(
      'Chats',
      name: 'chats_title',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_title {
    return Intl.message(
      'Search',
      name: 'search_title',
      desc: '',
      args: [],
    );
  }

  /// `The Cambridge School`
  String get search_school_hint {
    return Intl.message(
      'The Cambridge School',
      name: 'search_school_hint',
      desc: '',
      args: [],
    );
  }

  /// `Joey Tribbiani`
  String get search_student_hint {
    return Intl.message(
      'Joey Tribbiani',
      name: 'search_student_hint',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get button_search {
    return Intl.message(
      'Search',
      name: 'button_search',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scan_qr_code_title {
    return Intl.message(
      'Scan QR Code',
      name: 'scan_qr_code_title',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code to get user information`
  String get scan_qr_code_description {
    return Intl.message(
      'Scan QR code to get user information',
      name: 'scan_qr_code_description',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get button_reject {
    return Intl.message(
      'Reject',
      name: 'button_reject',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get button_accpet {
    return Intl.message(
      'Accept',
      name: 'button_accpet',
      desc: '',
      args: [],
    );
  }

  /// `Please enter school name or student name`
  String get school_name_and_student_name_error {
    return Intl.message(
      'Please enter school name or student name',
      name: 'school_name_and_student_name_error',
      desc: '',
      args: [],
    );
  }

  /// `is typing...`
  String get typing {
    return Intl.message(
      'is typing...',
      name: 'typing',
      desc: '',
      args: [],
    );
  }

  /// `Add friend`
  String get add_friend {
    return Intl.message(
      'Add friend',
      name: 'add_friend',
      desc: '',
      args: [],
    );
  }

  /// `This user is not yet your friend`
  String get not_friend {
    return Intl.message(
      'This user is not yet your friend',
      name: 'not_friend',
      desc: '',
      args: [],
    );
  }

  /// `Send request`
  String get send_request {
    return Intl.message(
      'Send request',
      name: 'send_request',
      desc: '',
      args: [],
    );
  }

  /// `You sent a friend request`
  String get send_request_content {
    return Intl.message(
      'You sent a friend request',
      name: 'send_request_content',
      desc: '',
      args: [],
    );
  }

  /// `You received a friend request`
  String get receive_invite_content {
    return Intl.message(
      'You received a friend request',
      name: 'receive_invite_content',
      desc: '',
      args: [],
    );
  }

  /// `New group`
  String get new_group_title {
    return Intl.message(
      'New group',
      name: 'new_group_title',
      desc: '',
      args: [],
    );
  }

  /// `sent a photo`
  String get sent_a_photo {
    return Intl.message(
      'sent a photo',
      name: 'sent_a_photo',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `Group name`
  String get group_name_title {
    return Intl.message(
      'Group name',
      name: 'group_name_title',
      desc: '',
      args: [],
    );
  }

  /// `Input message`
  String get input_message_hint {
    return Intl.message(
      'Input message',
      name: 'input_message_hint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
