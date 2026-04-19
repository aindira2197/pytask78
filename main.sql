CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Projects (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Commits (
    id INT PRIMARY KEY,
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Files (
    id INT PRIMARY KEY,
    commit_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (commit_id) REFERENCES Commits(id)
);

CREATE TABLE Branches (
    id INT PRIMARY KEY,
    project_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);

CREATE TABLE MergeRequests (
    id INT PRIMARY KEY,
    project_id INT NOT NULL,
    source_branch_id INT NOT NULL,
    target_branch_id INT NOT NULL,
    state VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(id),
    FOREIGN KEY (source_branch_id) REFERENCES Branches(id),
    FOREIGN KEY (target_branch_id) REFERENCES Branches(id)
);

CREATE TABLE MergeRequestComments (
    id INT PRIMARY KEY,
    merge_request_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (merge_request_id) REFERENCES MergeRequests(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE ProjectMembers (
    id INT PRIMARY KEY,
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    role VARCHAR(255) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Notifications (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    project_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);

INSERT INTO Users (id, username, email, password) VALUES (1, 'admin', 'admin@example.com', 'password123');

INSERT INTO Projects (id, name, description) VALUES (1, 'Example Project', 'This is an example project');

INSERT INTO Commits (id, project_id, user_id, message) VALUES (1, 1, 1, 'Initial commit');

INSERT INTO Files (id, commit_id, name, content) VALUES (1, 1, 'example.txt', 'This is an example file');

INSERT INTO Branches (id, project_id, name) VALUES (1, 1, 'main');

INSERT INTO MergeRequests (id, project_id, source_branch_id, target_branch_id, state) VALUES (1, 1, 1, 1, 'open');

INSERT INTO MergeRequestComments (id, merge_request_id, user_id, comment) VALUES (1, 1, 1, 'This is a comment');

INSERT INTO ProjectMembers (id, project_id, user_id, role) VALUES (1, 1, 1, 'admin');

INSERT INTO Notifications (id, user_id, project_id, message) VALUES (1, 1, 1, 'You have been assigned to a new project'); 

CREATE INDEX idx_users_username ON Users (username);
CREATE INDEX idx_projects_name ON Projects (name);
CREATE INDEX idx_commits_project_id ON Commits (project_id);
CREATE INDEX idx_files_commit_id ON Files (commit_id);
CREATE INDEX idx_branches_project_id ON Branches (project_id);
CREATE INDEX idx_merge_requests_project_id ON MergeRequests (project_id);
CREATE INDEX idx_merge_request_comments_merge_request_id ON MergeRequestComments (merge_request_id);
CREATE INDEX idx_project_members_project_id ON ProjectMembers (project_id);
CREATE INDEX idx_notifications_user_id ON Notifications (user_id);