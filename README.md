## Requirements

- [node & npm](http://nodejs.org)
- [MongoDB](https://www.mongodb.com/)
- 
- https://www.mongodb.com/try/download/compass
- https://www.mongodb.com/try/download
- 
- [PostMan](https://www.getpostman.com/)

## Installation

1. Clone the repository
2. Install the application: `npm install`
3. Place your own MongoDB URI in `credentials/mongo.js`
3. Start the server: `node server.js` or `node .`
4. Open PostMan and make a `GET` request to `http://localhost:3000/api/info/`

------------

## Commands

npm install --save-dev


## Run

node server.js
or
node .


------------

http://localhost:3000/api/v1/todo


#### End-Points
| Method | End-Point | Description |
| --- | --- | --- |
| `GET` | `/todo` | List all *todos* |
| `POST` | `/todo` | Create a new *todo* |
| `GET` | `/todo/:id` | Fetch a specific *todo* |
| `PUT` | `/todo/:id` | Edit existing *todo* |
| `PATCH` | `/todo/:id` | Mark an existing *todo* as complete |
| `DELETE` | `/todo/:id` | Delete existing *todo* |

----------
## Documentation
https://documenter.getpostman.com/view/8474302/SVfGyBSu
