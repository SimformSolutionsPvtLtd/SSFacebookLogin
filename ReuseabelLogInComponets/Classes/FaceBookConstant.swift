//
//  FaceBookConstante.swift
//  ReuseabelLogInComponets
//
//  Created by Sumit Goswami on 14/03/18.
//  Copyright © 2018 Simform Solutions PVT. LTD. All rights reserved.
//

import UIKit

//Basic permissions, (public_profile, user_friends, and email) do not require Review, but all other permissions do.
enum ReadPermissions :String {
    case email                    =  "email"
    case publicProfile            =  "public_profile"
    case readCustomFriendlists    =  "read_custom_friendlists"
    case userAboutMe              =  "user_about_me"
    case userBirthday             =  "user_birthday"
    case userEducationHistory     =  "user_education_history"
    case userFriends              =  "user_friends"
    case userHometown             =  "user_hometown"
    case userLocation             =  "user_location"
    case userRelationshipDetails  =  "user_relationship_details"
    case userRelationships        =  "user_relationships"
    case userReligionPolitics     =  "user_religion_politics"
    case userWorkHistory          =  "user_work_history"
}

enum NeededFields:String {
    case id                             = "id"                                  // user id
    case email                          = "email"                               /* The person's primary email address listed on their profile. This
                                                                                   field will not be returned if no valid email address is available */
    case pictureLarge                   = "picture.type(large)"                 // user large picture
    case picture                        = "picture"                             // user picture
    case name                           = "name"                                // string, The person's full name
    case gender                         = "gender"                              /* The gender selected by this person, male or female. This value will
                                                                                   be omitted if the gender is set to a custom value */
    case ageRange                       = "age_range"                           /* The age segment for this person expressed as a minimum and maximum
                                                                                   age.For example, more than 18, less than 21. */
    case coverPicture                   = "cover"                               // CoverPhoto
    case timezone                       = "timezone"                            // float(min: -24)(max: 24) The person's current timezone offset from UTC
    case verified                       = "verified"                            /* Indicates whether the account has been verified. This is distinct from
                                                                                   the is_verified field. Someone is considered verified if they take any of the following actions:
                                                                                                                Register for mobile
                                                                                                                Confirm their account via SMS
                                                                                                                Enter a valid credit card */
    case updated_time                   = "updated_time"                        // Updated time,datetime
    case education                      = "education"                           // The person's education
    case religion                       = "religion"                            // The person's religion
    case about                          = "about"                               // The person's bio
    case birthday                       = "birthday"                            /*  The person's birthday. This is a fixed format string,
                                                                                    like MM/DD/YYYY. However, people can control who can see the year they were born separately from the month and day so this string can be only the year (YYYY) or the month + day (MM/DD)*/
    case context                        = "context"                             // UserContext ,Social context for this person
    case currency                       = "currency"                            // The person's local currency information
    case devicesType                    = "devices"                             /* The list of devices the person is using. This will return only iOS and
                                                                                   Android devices */
    case favorite_athletes              = "favorite_athletes"                   // Athletes the person likes
    case favorite_teams                 = "favorite_teams"                      // Sports teams the person likes
    case firstName                      = "first_name"                          // The person's first name
    case hometown                       = "hometown"                            // The person's hometown
    case languages                      = "languages"                           // Facebook Pages representing the languages this person knows
    case lastName                       = "last_name"                           // The person's last name
    case installType                    = "install_type"                        // enum Install type
    case installed                      = "installed"                           // Is the app making the request installed?
    case interestedIn                   = "interested_in"                       // list ,Genders the person is interested in
    case isSharedLogin                  = "is_shared_login"                     // bool ,Is this a shared login (e.g. a gray user)
    case isVerified                     = "is_verified"                         /* bool, People with large numbers of followers can have the authenticity
                                                                                   of their identity manually verified by Facebook. This field indicates whether the person's profile is verified in this way. This is distinct from the verified field */
    case link                           = "link"                                // string, A link to the person's Timelinec
    case location                       = "location"                            /* Page, The person's current location as entered by them on their
                                                                                   profile. This field is not related to check-ins */
    case locale                         = "locale"                              // string, The person's locale
    case meetingFor                     = "meeting_for"                         // list, What the person is interested in meeting for
    case middleName                     = "middle_name"                         // string, The person's middle name
    case nameFormat                     = "name_format"                         /* string, The person's name formatted to correctly handle Chinese,
                                                                                   Japanese, or Korean ordering */
    case paymentPricepoints             = "payment_pricepoints"                 // PaymentPricepoints, The person's payment pricepoints
    case testGroup                      = "test_group"                          // unsigned int32, Platform test group
    case political                      = "political"                           // string, The person's political views
    case relationshipStatus             = "relationship_status"                 // string, The person's relationship status
    case securitySettings               = "security_settings"                   // Security settings
    case significantOther               = "significant_other"                   // User, The person's significant other
    case sports                         = "sports"                              // list, Sports this person likes
    case quotes                         = "quotes"                              // string, The person's favorite quotes
    case thirdPartyId                   = "third_party_id"                      /* string, A string containing an anonymous, but unique identifier for
                                                                                   the person. You can use this identifier with third parties */
    case tokenForBusiness               = "token_for_business"                  /*  string, A token that is the same across a business's apps. Access to
                                                                                    this token requires that the person be logged into your app. This token will change if the business owning the app changes */
    case sharedLoginUpgradeRequiredBy   = "shared_login_upgrade_required_by"    /* datetime,  The time that the shared loginneeds to be upgraded to
                                                                                   Business Manager by */
    case videoUploadLimits              = "video_upload_limits"                 // Video upload limits
    case viewerCanSendGift              = "viewer_can_send_gift"                // bool, Can the viewer send a gift to this person?
    case website                        = "website"                             // string, The person's website
    case work                           = "work"                                // list,Details of a person`s work experience
    case publicKey                      = "public_key"                          // string, The person's PGP public key
    case inspirational_people           = "inspirational_people"                // list, The person's inspirational people
}

struct Error {
    static let facebookNoResult:NSError = NSError(domain: "login", code:998 , userInfo: [NSLocalizedDescriptionKey:"Facebook Permissions Result",                                                                                                              NSLocalizedFailureReasonErrorKey:"No Facebook Permissions not Received"])
    static let facebookPermissions:NSError = NSError(domain: "login", code: 999, userInfo: [NSLocalizedDescriptionKey:"Facebook Permissions",                                                                                                         NSLocalizedFailureReasonErrorKey:"app requires you to provide additional Facebook Permissions in order to create or use a fb account.  This information is used to create fuller profiles, verify authenticity, and provide support"])
}

class FacebookConstante: NSObject {

    
    static let readPermissions = ["public_profile","email","user_friends"]
    
    static let neededFields = "id, name, first_name, last_name, picture, email, gender, birthday,about"
    
}
/*
 Manual Configuration
 
 Step 1: Configure Facebook App Settings for iOS
 Step 2: Download Facebook SDK Or Pod's for iOS
 Step 3: Add SDK to Project
 Step 4: Configure Xcode Project
 Step 5: Connect App Delegate
 Step 6: Add App Events
 */
