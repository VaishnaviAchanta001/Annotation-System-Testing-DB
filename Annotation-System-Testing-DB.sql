#Step 1: Create the Database
CREATE DATABASE TestCaseDB;
USE TestCaseDB;
#Step 2: Create Tables for System Testing
#Test Cases Table
CREATE TABLE TestCases (
    TestCaseID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Category VARCHAR(100),
    ImpactLevel ENUM('Low', 'Medium', 'High') NOT NULL DEFAULT 'Medium',
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
#Test Versions Table
CREATE TABLE TestVersions (
    VersionID INT PRIMARY KEY AUTO_INCREMENT,
    VersionNumber VARCHAR(20) NOT NULL,  
    ReleaseDate DATE,
    SystemStatus ENUM('Stable', 'Unstable') DEFAULT 'Stable'
);
#Test Executions Table
CREATE TABLE TestExecutions (
    ExecutionID INT PRIMARY KEY AUTO_INCREMENT,
    TestCaseID INT,
    VersionID INT,
    Status ENUM('Pass', 'Fail') NOT NULL,
    ExecutedBy VARCHAR(255),
    ExecutedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TestCaseID) REFERENCES TestCases(TestCaseID),
    FOREIGN KEY (VersionID) REFERENCES TestVersions(VersionID)
);
#System-Wide Failure Trends
CREATE TABLE FailureTrends (
    TrendID INT PRIMARY KEY AUTO_INCREMENT,
    TestCaseID INT,
    FailureCount INT DEFAULT 0,
    LastFailedVersion INT,
    FOREIGN KEY (TestCaseID) REFERENCES TestCases(TestCaseID)
);
ALTER TABLE TestCases MODIFY COLUMN ImpactLevel ENUM('Low', 'Medium', 'High', 'Critical');

-- Step 6: Insert Test Cases (45+ test cases)
INSERT INTO TestCases (Name, Description, Category, ImpactLevel) VALUES
('Create Polygon', 'Verify user can create a polygon', 'Functional', 'High'),
('Rotate Polygon', 'Verify user can rotate a polygon', 'Functional', 'Medium'),
('Delete Polygon', 'Check if polygon deletion works', 'Functional', 'High'),
('Copy and Paste Polygon', 'Ensure copying and pasting polygon retains properties', 'Functional', 'Medium'),
('Open Dataset', 'Confirm dataset can be opened without errors', 'Data Handling', 'High'),
('Merge Dataset', 'Verify multiple datasets can be merged correctly', 'Data Handling', 'High'),
('Save Changes', 'Ensure all changes are saved without data loss', 'Functional', 'Critical'),
('Create Label', 'Check if users can create labels for polygons', 'Annotation', 'Medium'),
('Change Label', 'Ensure labels can be modified after creation', 'Annotation', 'Low'),
('Change Color of Label', 'Verify users can change polygon label colors', 'Annotation', 'Low'),
('Measure Line', 'Check if line measurements are accurate', 'Measurement', 'Medium'),
('Zoom In and Out', 'Ensure zoom functionality works smoothly', 'UI/UX', 'Low'),
('Undo Action', 'Verify users can undo the last action', 'Functional', 'High'),
('Redo Action', 'Ensure redo functionality restores the last undone action', 'Functional', 'Medium'),
('Delete Label', 'Check if labels can be deleted properly', 'Annotation', 'Low'),
('Export Dataset', 'Verify datasets can be exported in required formats', 'Data Handling', 'High'),
('Import Dataset', 'Ensure dataset import works without errors', 'Data Handling', 'High'),
('Pan View', 'Verify panning across the workspace is smooth', 'UI/UX', 'Low'),
('Resize Polygon', 'Check if polygons can be resized correctly', 'Functional', 'Medium'),
('Select Multiple Objects', 'Ensure users can select multiple polygons at once', 'UI/UX', 'Medium'),
('Apply Filters', 'Check if filtering functionality works correctly', 'Data Handling', 'Medium'),
('Auto Save', 'Ensure auto-save functionality works without issues', 'Functional', 'Critical'),
('Load Large Dataset', 'Test performance when opening large datasets', 'Performance', 'High'),
('Switch Theme', 'Verify users can toggle between dark and light mode', 'UI/UX', 'Low'),
('User Login', 'Ensure login system works as expected', 'Authentication', 'Critical'),
('Forgot Password', 'Check if password recovery process functions correctly', 'Authentication', 'High'),
('Edit Profile', 'Verify users can edit their profile details', 'User Management', 'Medium'),
('Logout', 'Ensure users can log out successfully', 'Authentication', 'Medium'),
('View Version History', 'Check if users can view change history of datasets', 'Functional', 'Low'),
('Drag and Drop', 'Verify drag-and-drop functionality for files and objects', 'UI/UX', 'Medium');
-- Step 7: Insert Versions
INSERT INTO TestVersions (VersionNumber, ReleaseDate) VALUES
('v1.0', '2024-01-01'),
('v2.0', '2024-02-01'),
('v3.0', '2024-03-01'),
('v4.0', '2024-04-01'),
('v5.0', '2024-05-01'),
('v6.0', '2024-06-01'),
('v7.0', '2024-07-01'),
('v8.0', '2024-08-01'),
('v9.0', '2024-09-01'),
('v10.0', '2024-10-01');
-- Step 8: Implement System Testing Procedure
DELIMITER $$
CREATE PROCEDURE CheckSystemStability(IN CurrVersionID INT)
BEGIN
    DECLARE FailedTests INT;
    
    -- Count the number of failed tests for the version
    SELECT COUNT(*) INTO FailedTests FROM TestExecutions WHERE VersionID = CurrVersionID AND Status = 'Fail';
    
    -- If any test fails, mark system as unstable
    IF FailedTests > 0 THEN
        UPDATE TestVersions SET SystemStatus = 'Unstable' WHERE VersionID = CurrVersionID;
    ELSE
        UPDATE TestVersions SET SystemStatus = 'Stable' WHERE VersionID = CurrVersionID;
    END IF;
END$$
DELIMITER ;
-- Step 9: Run System Testing for Each Version
CALL CheckSystemStability(6);
CALL CheckSystemStability(7);
CALL CheckSystemStability(8);
CALL CheckSystemStability(9);
CALL CheckSystemStability(10);
-- Step 10: Retrieve All Unstable Versions
SELECT VersionNumber, SystemStatus FROM TestVersions WHERE SystemStatus = 'Unstable';
-- Retrieve All Unstable Versions

SELECT VersionNumber, SystemStatus FROM TestVersions WHERE SystemStatus = 'Unstable';

-- Check all failed test executions

SELECT * FROM TestExecutions WHERE Status = 'Fail';

-- Retrieve test execution history for a specific test case

SELECT * FROM TestExecutions WHERE TestCaseID = 1;

-- Get all test cases that have a critical impact level

SELECT * FROM TestCases WHERE ImpactLevel = 'Critical';
