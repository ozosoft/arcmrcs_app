class BattleRoomHelper {
  static const String battleroomCollection = 'battleRoom';
  static const String battleroomCollectionMulti = 'battleRoomMulti';
  static const roomCodeGenerateCharacters = "1234567890"; //Numeric

  static const demoQuestionList = {
    "remark": "general_quiz_question_list",
    "status": "success",
    "message": {
      "success": [""]
    },
    "data": {
      "quizInfo": {
        "id": 128,
        "type_id": "1",
        "category_id": "5",
        "sub_category_id": "9",
        "title": null,
        "image": null,
        "start_date": null,
        "end_date": null,
        "prize": null,
        "point": null,
        "description": null,
        "level_id": "1",
        "exam_start_time": "10:35 am",
        "exam_end_time": "10:35 am",
        "exam_duration": null,
        "exam_key": null,
        "winning_mark": 70,
        "status": "1",
        "created_at": "2023-08-05T01:33:47.000000Z",
        "updated_at": "2023-08-16T06:20:58.000000Z",
        "play_info": null
      },
      "questions": [
        {
          "id": 65,
          "question": "Adipisci occaecat ex",
          "image": null,
          "code": "TM65",
          "status": "1",
          "created_at": "2023-07-25T21:55:00.000000Z",
          "updated_at": "2023-07-25T21:55:00.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "65"},
          "options": [
            {
              "id": 824,
              "question_id": "65",
              "option": "Duis voluptatum fugi",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-25T21:55:00.000000Z",
              "updated_at": "2023-07-25T21:55:00.000000Z"
            },
            {
              "id": 825,
              "question_id": "65",
              "option": "Eligendi perferendis",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-25T21:55:00.000000Z",
              "updated_at": "2023-07-25T21:55:00.000000Z"
            },
            {
              "id": 826,
              "question_id": "65",
              "option": "Sint ullamco accusam",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-25T21:55:00.000000Z",
              "updated_at": "2023-07-25T21:55:00.000000Z"
            },
            {
              "id": 827,
              "question_id": "65",
              "option": "Occaecat omnis aut e",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-25T21:55:00.000000Z",
              "updated_at": "2023-07-25T21:55:00.000000Z"
            }
          ]
        },
        {
          "id": 62,
          "question": "Est cum odit error i",
          "image": null,
          "code": "",
          "status": "1",
          "created_at": "2023-07-23T21:08:21.000000Z",
          "updated_at": "2023-07-25T00:42:26.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "62"},
          "options": [
            {
              "id": 808,
              "question_id": "62",
              "option": "Debitis est dolore m",
              "is_answer": "1",
              "audience": "1",
              "created_at": "2023-07-23T21:08:21.000000Z",
              "updated_at": "2023-08-12T21:24:32.000000Z"
            },
            {
              "id": 809,
              "question_id": "62",
              "option": "Animi quisquam nequ",
              "is_answer": "1",
              "audience": "1",
              "created_at": "2023-07-23T21:08:21.000000Z",
              "updated_at": "2023-08-12T21:24:32.000000Z"
            },
            {
              "id": 810,
              "question_id": "62",
              "option": "Cillum qui necessita",
              "is_answer": "1",
              "audience": "1",
              "created_at": "2023-07-23T21:08:21.000000Z",
              "updated_at": "2023-08-12T21:24:32.000000Z"
            },
            {
              "id": 811,
              "question_id": "62",
              "option": "Et quis sed eligendi",
              "is_answer": "1",
              "audience": "1",
              "created_at": "2023-07-23T21:08:21.000000Z",
              "updated_at": "2023-08-12T21:24:32.000000Z"
            }
          ]
        },
        {
          "id": 61,
          "question": "Nam exercitation qua",
          "image": null,
          "code": "",
          "status": "1",
          "created_at": "2023-07-23T21:01:32.000000Z",
          "updated_at": "2023-07-23T21:01:32.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "61"},
          "options": [
            {
              "id": 804,
              "question_id": "61",
              "option": "Quo laborum Nulla q",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-23T21:01:32.000000Z",
              "updated_at": "2023-07-23T21:01:32.000000Z"
            },
            {
              "id": 805,
              "question_id": "61",
              "option": "Tempor voluptas ad d",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-23T21:01:32.000000Z",
              "updated_at": "2023-07-23T21:01:32.000000Z"
            },
            {
              "id": 806,
              "question_id": "61",
              "option": "Natus quam eum iste",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-23T21:01:32.000000Z",
              "updated_at": "2023-07-23T21:01:32.000000Z"
            },
            {
              "id": 807,
              "question_id": "61",
              "option": "Veritatis eos paria",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-23T21:01:32.000000Z",
              "updated_at": "2023-07-23T21:01:32.000000Z"
            }
          ]
        },
        {
          "id": 51,
          "question": "Accusantium anim dol 20",
          "image": null,
          "code": "",
          "status": "0",
          "created_at": "2023-07-21T22:22:56.000000Z",
          "updated_at": "2023-07-21T23:03:55.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "51"},
          "options": [
            {
              "id": 866,
              "question_id": "51",
              "option": "Quae modi sed verita",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-26T20:14:45.000000Z",
              "updated_at": "2023-07-26T20:14:45.000000Z"
            },
            {
              "id": 867,
              "question_id": "51",
              "option": "Qui tempore aliquip",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-26T20:14:45.000000Z",
              "updated_at": "2023-07-26T20:14:45.000000Z"
            }
          ]
        },
        {
          "id": 63,
          "question": "Proin viverra ligula sit amet",
          "image": null,
          "code": "A963",
          "status": "1",
          "created_at": "2023-07-24T01:36:57.000000Z",
          "updated_at": "2023-07-24T01:36:57.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "63"},
          "options": [
            {
              "id": 818,
              "question_id": "63",
              "option": "Reiciendis et sit u",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-24T02:45:15.000000Z",
              "updated_at": "2023-07-24T02:45:15.000000Z"
            },
            {
              "id": 819,
              "question_id": "63",
              "option": "Voluptates corporis",
              "is_answer": "1",
              "audience": "1",
              "created_at": "2023-07-24T02:45:15.000000Z",
              "updated_at": "2023-08-12T21:24:32.000000Z"
            }
          ]
        },
        {
          "id": 59,
          "question": "Error nobis exercita",
          "image": null,
          "code": "",
          "status": "1",
          "created_at": "2023-07-23T18:47:35.000000Z",
          "updated_at": "2023-07-23T18:47:35.000000Z",
          "pivot": {"quiz_info_id": "128", "question_id": "59"},
          "options": [
            {
              "id": 798,
              "question_id": "59",
              "option": "Excepturi tenetur au",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-23T18:47:42.000000Z",
              "updated_at": "2023-07-23T18:47:42.000000Z"
            },
            {
              "id": 799,
              "question_id": "59",
              "option": "Sit amet est offic",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-23T18:47:42.000000Z",
              "updated_at": "2023-07-23T18:47:42.000000Z"
            },
            {
              "id": 800,
              "question_id": "59",
              "option": "Ipsum accusantium a",
              "is_answer": "1",
              "audience": null,
              "created_at": "2023-07-23T18:47:42.000000Z",
              "updated_at": "2023-07-23T18:47:42.000000Z"
            },
            {
              "id": 801,
              "question_id": "59",
              "option": "Adipisicing laborios",
              "is_answer": "0",
              "audience": null,
              "created_at": "2023-07-23T18:47:42.000000Z",
              "updated_at": "2023-07-23T18:47:42.000000Z"
            }
          ]
        }
      ],
      "flipQuestion": {
        "id": 24,
        "question": "test sports",
        "image": null,
        "code": "",
        "status": "1",
        "created_at": "2023-07-16T01:05:14.000000Z",
        "updated_at": "2023-07-16T01:05:14.000000Z",
        "options": [
          {
            "id": 674,
            "question_id": "24",
            "option": "Consectetur adipisi",
            "is_answer": "0",
            "audience": null,
            "created_at": "2023-07-19T23:17:41.000000Z",
            "updated_at": "2023-07-19T23:17:41.000000Z"
          },
          {
            "id": 675,
            "question_id": "24",
            "option": "Voluptatem ex except",
            "is_answer": "1",
            "audience": null,
            "created_at": "2023-07-19T23:17:41.000000Z",
            "updated_at": "2023-07-19T23:17:41.000000Z"
          }
        ]
      },
      "question_image_path":
          "http://url8.viserlab.com/quizlab/assets/admin/images/question"
    }
  };
}
