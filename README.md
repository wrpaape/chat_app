#Chatroom App
###Description
- Users should be able to set a username and post messages to a single chat room.
- Any user who is in that chat room should see all messages that are posted along with the username of the person who posted them and the date and time they were posted.
- Users should be able to change their name and have the new name show up in future messages. Old messages can keep the old username.
- Messages should appear on the page without having to refresh the page.
- When a user enters a chat room, it should only show the last five minutes of messages (not the whole chat history). Bonus points if you can make the five minute window configurable so that it can be easily changed in the future.
- In addition to the chat room page, there should be a leaderboard page that displays the following information:
  - Top ten usernames ranked by the number of total messages that they posted.
  - Most active chat rooms ranked by the number of messages posted in that room.
  - A list of users who have posted a message in the last four hours. Bonus points if you can make the four hour window configurable so that it can be easily changed in the future.

- Support emoticons in your chat application (hint: google "jquery emoticon plugin")
- Add support for multiple chat rooms. Users in one chat room should not see messages that are posted in a different room.
- Play a sound anytime a new chat is posted into your chat room (hint: google "play sound with javascript")
- Implement a swear word filter. We need to keep things PG. No four letter words should be printed into the chat room. Instead display '****'
- Create a chat bot that automatically responds to certain messages with responses. For example, if a user types in "amiright" the chat bot would automatically respond with "you are so right!"

- If a link to a gif, jpg, or png image url is posted into chat, show that image in addition to the link.
- Play a sound only if a message is posted in the chat room that includes @
Be able to view the history of a chat room by specifying a start and end date. (hint: http://localhost:3000/room/foo/1-27-14/1-29-14)
- Add a profile page to show all messages for a particular user.

###Setup
- Fork this repo
- Clone this repo
- Enter the following in the terminal under the path of your cloned directory:

```
$ bundle install
$ rake db:setup
$ rails s
```
- Now you can access the api locally
- Additionally this api is stored on the heroku server:  https://agile-chamber-3594.herokuapp.com
- refer to https://hackpad.com/ChatApp-nGvuzho20ca for basic database structure, and how to route and form data queries
- refer to https://trello.com/b/B79on2Oz/chat-app for project timeline
- refer to https://awg24.github.io/dist/ for the complete chatroom app

###Topics
- Learn about the core principles of Agile development.
- Learn how to use github issues for managing a project.
- Learn about markdown for writing documentation.

###Takeaway
- tears, tears, and more tears
- be very explicit with FE about how their data will be formatted


###Contents of this repo

```
.
├── Gemfile
├── Gemfile.lock
├── Procfile
├── README.md
├── README.rdoc
├── Rakefile
├── app
│   ├── assets
│   │   ├── images
│   │   ├── javascripts
│   │   │   ├── application.js
│   │   │   ├── chatrooms.coffee
│   │   │   ├── messages.coffee
│   │   │   └── users.coffee
│   │   └── stylesheets
│   │       ├── application.css
│   │       ├── chatrooms.scss
│   │       ├── messages.scss
│   │       └── users.scss
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── chatrooms_controller.rb
│   │   ├── concerns
│   │   ├── messages_controller.rb
│   │   └── users_controller.rb
│   ├── helpers
│   │   ├── application_helper.rb
│   │   ├── chatrooms_helper.rb
│   │   ├── messages_helper.rb
│   │   └── users_helper.rb
│   ├── mailers
│   ├── models
│   │   ├── chatroom.rb
│   │   ├── concerns
│   │   ├── message.rb
│   │   └── user.rb
│   └── views
│       ├── chatrooms
│       ├── layouts
│       │   └── application.html.erb
│       ├── messages
│       └── users
├── bin
│   ├── bundle
│   ├── rails
│   ├── rake
│   ├── setup
│   └── spring
├── config
│   ├── application.rb
│   ├── boot.rb
│   ├── database.yml
│   ├── environment.rb
│   ├── environments
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   ├── initializers
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── cookies_serializer.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── mime_types.rb
│   │   ├── session_store.rb
│   │   └── wrap_parameters.rb
│   ├── locales
│   │   └── en.yml
│   ├── routes.rb
│   └── secrets.yml
├── config.ru
├── db
│   ├── development.sqlite3
│   ├── migrate
│   │   ├── 20150605140108_create_messages.rb
│   │   ├── 20150605184605_create_chatrooms.rb
│   │   └── 20150608005853_create_users.rb
│   ├── schema.rb
│   ├── seeds.rb
│   └── test.sqlite3
├── lib
│   ├── assets
│   └── tasks
├── log
│   └── development.log
├── public
│   ├── 404.html
│   ├── 422.html
│   ├── 500.html
│   ├── assets
│   │   ├── application-34bdfe4bab44405a24fc5e452fa65c934a8f46595b047d3cc611b65f7db048c7.js
│   │   └── application-e80e8f2318043e8af94dddc2adad5a4f09739a8ebb323b3ab31cd71d45fd9113.css
│   ├── favicon.ico
│   └── robots.txt
├── test
│   ├── controllers
│   │   ├── chatrooms_controller_test.rb
│   │   ├── messages_controller_test.rb
│   │   └── users_controller_test.rb
│   ├── fixtures
│   │   ├── chatrooms.yml
│   │   ├── messages.yml
│   │   └── users.yml
│   ├── helpers
│   ├── integration
│   ├── mailers
│   ├── models
│   │   ├── chatroom_test.rb
│   │   ├── message_test.rb
│   │   └── user_test.rb
│   └── test_helper.rb
├── tmp
│   ├── cache
│   │   └── assets
│   │       └── development
│   │           └── sprockets
│   │               └── v3.0
│   │                   ├── -B2JHlSWDVpsrp6xDSg10UWiZJX1xTmwFlpbmIv8o2Y.cache
│   │                   ├── 2JQnldKbJP4YlQVJJZqVU_97_szA-ozAYXZj7vhoOFM.cache
│   │                   ├── 2QCVg3OEPVAYMnJ8taw5Rua3G3TKDpRuL18KkPKjBT4.cache
│   │                   ├── 3APRZ09I6l4peCCrSCQ3svNbd3sL-CABZBO3oNQD97s.cache
│   │                   ├── 3xMet-EdqDCLa0YIK-cKfZffowGIjmFjRhiFEwp0JJQ.cache
│   │                   ├── 4RozN6hr_VySXAE2K40P7NA58y5Mh11qG7kLy6W5mYI.cache
│   │                   ├── 4X-Zo0Ztl3_o2xBu-GbcPnCZ6XyhzdApFAc95Zr8COo.cache
│   │                   ├── 5CxjVwJROSO57JOvl2LanVpTv7XZCD2JGUTSOkuDGjs.cache
│   │                   ├── 6Mz_n_S0bYXs9fjRSCmmb6LBlcjbF42r4z0IKe6MUAo.cache
│   │                   ├── 7T9irj4OaxjSY2ndISTgHaCwLF0vyP-hwmE7kzz5U6w.cache
│   │                   ├── 8XJvOW2i3fZAT9tjZSDLiMEJ6Vwa9RfofWuOcSOXkrg.cache
│   │                   ├── 8qvrrGjkPo-XSm1iTtWVsJVo2b4gri8-4vVm0KdoYDg.cache
│   │                   ├── 9P3-eliQY406jskWX5kt-GImyNLJqlUffLU8-8GLc3o.cache
│   │                   ├── 9pJ82WoO_gf2k0VyEPqQWlgtYdp-M0X3ZB6eWSoZwjk.cache
│   │                   ├── ACUsi3bgbj3VwMOCvvgqS1pxdSCEjZOpwjSC8fgUxAw.cache
│   │                   ├── AlpnGJVDZ3Ot5-N2dguf54hBiUomGR1roVwH7a37ETw.cache
│   │                   ├── DmxzS6MQfzD2_6sPBZAICIlSJ-tMjKgkFFswp0IJFuY.cache
│   │                   ├── EcCytL3id9CKzv5xWX2OskY96_VktrWBl_xwUAs8hPY.cache
│   │                   ├── F9ndNiX076dIeYYKSgLTqhyPe-vWEatuOuOG6UIH0yI.cache
│   │                   ├── FWhCuJrN3uV50xYspHLrgyqmh9E5vseelX24DEpZrFA.cache
│   │                   ├── GvUEvruCyNT3iu1E4gsu4q1u6080n16cw1VdRjXOnc8.cache
│   │                   ├── IjVdlFTEYHJZdyFpdLw8M2-3ZObR2uBDFfk1bln3rfM.cache
│   │                   ├── K9j9Mo7V187x0ApPydjhynaEGkVEaU8yuEWrWEw_BNk.cache
│   │                   ├── KU46lDH6NIYuaiBVwASx-vWVBPXtfc4LzUUyxfVrDkA.cache
│   │                   ├── KVLRlP8_ZddMFsTuVFvHN55OssVrQfiQYVRdWpjmxX8.cache
│   │                   ├── M6ygVxOuH7Cc8c2XUeQFEaPNdLS660zORvSsw9SxF-Y.cache
│   │                   ├── MkSNraNZcktXvbndtNCiGKmUJPm5HHfBoXrlzijpnZ8.cache
│   │                   ├── MqdHCrYXlYG4FTXyjHUeoReAdXiBs_AHWHOCxKF3N10.cache
│   │                   ├── NS8neQqq9U4n77NsRHmi91oMQqfZHdD53xx6O5L1e7Y.cache
│   │                   ├── Ols0r0IRZxkKcucwnoQKfREkbxCH18h-ODsapRDxS8I.cache
│   │                   ├── Pumaw_VRfmek3meMxF42N__fCpwamBGxsy-SJW5B2DM.cache
│   │                   ├── Qa8k7GZHWMY3KMfXaQPxitNZmPeWZU2u6K5Kn8daucM.cache
│   │                   ├── R1sWGYrOxYTPaM6-sekWdLoJsa4C1UAPtA7Pd05LKKY.cache
│   │                   ├── S_o0kOM5f9y0TTtAyMxKtxGTb97FKLPqKAaQAuGG_sA.cache
│   │                   ├── UamzH-E-YuV7ZBSofnsnSB1iwcTzq3uPdJygQP_CqEY.cache
│   │                   ├── V66F99GrgWo7WrvSZi7LX4sZnE0aj5hxcNUYd3mJFpU.cache
│   │                   ├── VH3jz6H0tIkserBAayBa-ElO_WjER11LabQ98OKUGww.cache
│   │                   ├── VOp0pIv_pTt1jyD5JQn5Ee721CyQFQTGdnz4ODw38i4.cache
│   │                   ├── VsY80f2JoZ5wEzhm_a3YkRCmEDE1elOi0a7ffsM1ljI.cache
│   │                   ├── ZNvdbZEuqu_TYQCqZRdmv-7_59FfijmStj9cV8lAzUo.cache
│   │                   ├── cmLFuL1bjwKG2w_vT93KWK1F8fEcA9qwi0dcE9q90Go.cache
│   │                   ├── dtNKb7WD10aMZqBiaShg5HT_Ie2XfhzROY8BTMhoebg.cache
│   │                   ├── eVuIKBZN5Y8xMkdaKjWiJ7KON4dgqLJjv9DS6ajW4CU.cache
│   │                   ├── e_2rqJtklmyMp36I4NFbhZaX18uCc676685LvUWR8ws.cache
│   │                   ├── fi7h0ULk1QrdEa4Jc3WCUf_UmSVSDrOjwwe7F-mrCxo.cache
│   │                   ├── lBM0VeVnnUBqCN-vftjrgDbnrMTdbXvl6RF9gYUUA24.cache
│   │                   ├── mC6XfMrQerVUhLE8FxCkWLxga1cS0JBaP2hLUbvfayI.cache
│   │                   ├── mxZzTdZz00RJTEO393qeJOm3bb4LVcr3m6wPKlfjhRw.cache
│   │                   ├── n25xrVE6LogGm_1CE8hgRH4xKg8Cm5nhJaP2wb2n7VI.cache
│   │                   ├── nv7FgWyCzCtKVBR7IiqzQkuMhnokUPPXy2Ea_3qLdas.cache
│   │                   ├── tH96k1D5bcWXvEl8Fm7u23sByQgWWl24TGLdZ_GCLPs.cache
│   │                   ├── tMxLidqd9-1lJhNve2mNctuqdwkeiuCZ1FiQc1Fpwzc.cache
│   │                   ├── uBl0mz_P9ll_mW00mR297ZyhmTpl20474wmgvIqMuD0.cache
│   │                   ├── vxSGp_dMNBorxXGDthoh6_6Plv8FKEJs7q81XgK0dCc.cache
│   │                   ├── w9NxubuggrCLzwY9Zqu3wCG5JQyZiSstH3uH9CMG3lI.cache
│   │                   ├── wgAqXjoydzHj-sY4ZAAwfXRK8fATZD2vEOavwnaqbC8.cache
│   │                   ├── x11o7pZ9BvubWUlEn1BxFk0Tx_5ycf2IcwK32LmblEw.cache
│   │                   ├── xChL3H4gqiX5maPUDM_-z7y5RrLjNtystddxp_8c9os.cache
│   │                   ├── xq_qRGEiJNK_99yq_jROAJwne5qE7z4irY_Rst5t_p8.cache
│   │                   ├── y4_KobXNBrNjAuiQci788n3yAXKyBxQLuwh8-IVXVds.cache
│   │                   ├── yf-uWKqc4UmDPMcYqBRBP85z2FXNwDtXQ2GiuNa-LlQ.cache
│   │                   └── zyGGkhOHsyMd2To1V8wMxAOV5ooBe9guHKr89UDJo-U.cache
│   ├── pids
│   │   └── server.pid
│   ├── sessions
│   └── sockets
└── vendor
    └── assets
        ├── javascripts
        └── stylesheets
```




