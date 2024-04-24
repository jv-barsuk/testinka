# Testinka
Testinka is a tool to manage your test suits based on YAML files.

## Get started
Run Testinka by executing
~~~
npm run start
~~~
go to `https://localhost:3000/?project={folder_name_of_project_in_data_dir}&scenario={name_of_scenario_file}` to open a test. Replace `{folder_name_of_project_in_data_dir}` and `{name_of_scenario_file}` accordingly. The name of the scenario file should be given without the postfix - so if the file is called `myapplication_basic_test.scenario.yml` just pass `myapplication_basic_test` in the URL.

## Deploy (Docker)
Deploy Testinka on a server by running
~~~
docker-compose up -d
~~~

it might be necessary to change the external port, depending on your setup
~~~
...
    ports:
      - 3015:3000 #externalPort (change):internalPort (don't change)
~~~

the data directory can be updated during runtime - so no restart is required to reload new tests.


### Structure
- **Test Suits:** a collection of all tests for a specific application.
- **Section:** organizes tests hierarchically within a test suite e.g. all login tests, feature tests.
- **Test case:** can ideally be verified by a single tester in a short period of time and confirms a specific functionality, documents a task or verifies a project artifact.
- **Test step:** single action within a test case, which can be done by executing a single action or at least very few.
  
- **Collection:** a way to group different test cases in a functional unit.
- **Scenarios:** a way to execute a test collection with variable parameters e.g. online test vs. offline test.
  
### Build your own tests
#### Prerequisites
* Bash
* yq

Run `apt install yq` to install yq.

To build your test suite and make it available, you have to run `./build.sh`, this transforms all YAMLs in a JSON containing the entire structures and makes it available in the GUI.

Tests are organized in the following file structure:
~~~
data
 └ collections
   └ myapplication_basic_test.collection.yml
   └ myapplication_release_test.collection.yml
   └ myapplication_video_test.collection.yml
 └ scenarios
   └ myapplication_basic_test.scenario.yml
 └ suites
   └ e.g. login
     └ basic_login.testcase.yml
   └ e.g. player
     └ basic.testcase.yml
~~~

#### Test case
define your test case and the steps required to fulfill it. All testcase files must be named with the postfix `.testcase.yml`.
~~~
- &id_basic_test
    name:
    description:
    steps:
    -
        name: 
        description:
        url:
        expected_result: 
~~~
- **&id_basic_test** is the unique referrer which is used to link to this test case
- **steps** are the steps of the test case, consisting of
  - **name:** which describes the step and makes clear what to do
  - **description:** additional information about how the step is to be executed
  - **url:** link displayed next to the name
  - **expected_result:** expected result to make clear if the test step was successful

All fields can be empty.

#### Collection
All collection files must be named with the postfix `.collection.yml`.
define information about the collection and link individual test cases to it
~~~
- &collection_basic_test
    name: Basic Tests
    description: Description of this test collection
    test_cases:
    - *id_basic_test
~~~
- **&collection_basic_test** is the unique referrer which is used to link to this test case
- **test_cases** list of test cases used in this collection
- **- *id_basic_test** link to a test case, identified by the id "id_basic_test"

#### Scenarios
All scenario files must be named with the postfix `.scenario.yml`.
~~~
- &scenario_basic_test
    name: Basic Scenario (online/offline)
    description:
    scenario:
        -
            collection: *collection_video_test
            variables: 
                - online
        -   collection: *collection_video_test
            variables:
                - offline
~~~
- **&scenario_basic_test** is the unique referrer which could be used to link to this test scenario
- **scenario:** links to the collections with different variables/parameters
  - **collection: *collection_video_test** link to the collection with the referrer "collection_video_test"
  - **variables** variables which define this scenario


