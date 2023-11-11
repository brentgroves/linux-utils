https://docs.phpunit.de/en/9.5/configuration.html

3. The XML Configuration File
The <phpunit> Element
The backupGlobals Attribute
Possible values: true or false (default: false)

PHPUnit can optionally backup all global and super-global variables before each test and restore this backup after each test.

This attribute configures this operation for all tests. This configuration can be overridden using the @backupGlobals annotation on the test case class and test method level.

The backupStaticAttributes Attribute
Possible values: true or false (default: false)

PHPUnit can optionally backup all static attributes in all declared classes before each test and restore this backup after each test.

The <listeners> Element
Parent element: <phpunit>

The <listeners> element and its <listener> children can be used to attach additional test listeners to the test execution.

The <listener> Element
Parent element: <listeners>

<listeners>
  <listener class="MyListener" file="/optional/path/to/MyListener.php">
    <arguments>
      <array>
        <element key="0">
          <string>Sebastian</string>
        </element>
      </array>
      <integer>22</integer>
      <string>April</string>
      <double>19.78</double>
      <null/>
      <object class="stdClass"/>
    </arguments>
  </listener>
</listeners>
The XML configuration above corresponds to attaching the $listener object (see below) to the test execution:

$listener = new MyListener(
    ['Sebastian'],
    22,
    'April',
    19.78,
    null,
    new stdClass
);
Note

Please note that the PHPUnit\Framework\TestListener interface is deprecated and will be removed in the future. TestRunner extensions should be used instead of test listeners.

