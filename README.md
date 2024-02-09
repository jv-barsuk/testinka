# Testinka
Testinka is a tool to manage your test suits based on YAML files.

## Get started
Run Testinka by executing
~~~
npm run start
~~~
go to https://localhost:3000 to open the interface.

### Structure
- **Test Suits:** a collection of all tests for a specific application.
- **Section:** organizes tests hierachically within a test suite e.g. all login tests, feature tests.
- **Test case:** can ideally be verified by a single tester in a short period of time and confirms a specific functionality, documents a task or verifies a project artifact.
- **Test step:** single action within a test case, which can be done by executing a single action or at least very few.
  
- **Collection:** a way to group different test cases in a functional unit.
- **Scenarios:** a way to execute a test collection with variable parameters e.g. online test vs. offline test.
  
### Build your own tests
#### Prerequisites
* Bash
* yq

Run `apt install yq` to install yd.

To build your test suite and make it available, you have to run `build.sh`, this transforms all YAMLs in a JSON containing the entire structures and makes it available in the GUI.

Tests are organized in the following file structure:
~~~
data
 └ collections
   └ myapplication_basic_test.yml
   └ myapplication_release_test.yml
   └ myapplication_video_test.yml
 └ scenarios
   └ myapplication_basic_test.yml
 └ suites
   └ suite.yml 
   └ e.g. login
     └ section.yml
     └ testcase_basic.ym
   └ e.g. player
     └ section.yml
     └ testcase_basic.ym
~~~

#### Suite
define information about the suite
~~~
type: suite
type_description: collection of all tests that can be separated from another
name: my_suite_name
description: describe your suite here
~~~

#### Section
define information about the section
~~~
type: section
type_description: organize test cases hierachically e.g. all video tests, all login tests
name: Unsorted Section
description: describe your section here
~~~

#### Test case
define your test case and the steps required to fullfill it
~~~
- &id_basic_test
    type: test_case
    type_description:  A test case can ideally be verified by a single tester in a short period of time and confirms a specific functionality, documents a task or verifies a project artifact.
    id: basic_test
    name:
    description:
    steps:
    -
        type: test step
        name: 
        description:
        expected_result: 
~~~
- **&id_basic_test** is the unique referrer which is used to link to this test case
- **id: basic_test** 
- **steps** are the steps of the test case, consisting of
  - **type: test step** type definition to identify it as test step
  - **name:** which describes the step and makes clear what to do
  - **description:** additional information about how the step is to be executed
  - **expected_result:** expected result to make clear if the test step was successful

#### Collection
define information about the collection and link individual test cases to it
~~~
- &collection_basic_test
    type: collection
    name: Basic Tests
    description: Description of this test collection
    test_cases:
    - *id_basic_test
~~~
- **&collection_basic_test** is the unique referrer which is used to link to this test case
- **test_cases** list of test cases used in this collection
- **- *id_basic_test** link to a test case, identified by the id "id_basic_test"

#### Scenarios
~~~
- &scenario_basic_test
    type: scenario
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


