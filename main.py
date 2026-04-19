class VersionControl:
    def __init__(self):
        self.files = {}
        self.history = []

    def add_file(self, filename, content):
        self.files[filename] = content
        self.history.append((filename, content, "added"))

    def update_file(self, filename, new_content):
        if filename in self.files:
            old_content = self.files[filename]
            self.files[filename] = new_content
            self.history.append((filename, old_content, "updated", new_content))
        else:
            raise ValueError("File not found")

    def delete_file(self, filename):
        if filename in self.files:
            content = self.files[filename]
            del self.files[filename]
            self.history.append((filename, content, "deleted"))
        else:
            raise ValueError("File not found")

    def get_file(self, filename):
        if filename in self.files:
            return self.files[filename]
        else:
            raise ValueError("File not found")

    def get_history(self):
        return self.history

class VersionControlSystem:
    def __init__(self):
        self.version_control = VersionControl()

    def create_version(self, version_name):
        self.version_control = VersionControl()

    def add_file_to_version(self, filename, content):
        self.version_control.add_file(filename, content)

    def update_file_in_version(self, filename, new_content):
        self.version_control.update_file(filename, new_content)

    def delete_file_from_version(self, filename):
        self.version_control.delete_file(filename)

    def get_file_from_version(self, filename):
        return self.version_control.get_file(filename)

    def get_version_history(self):
        return self.version_control.get_history()

vcs = VersionControlSystem()
vcs.create_version("v1")
vcs.add_file_to_version("file1.txt", "content1")
vcs.add_file_to_version("file2.txt", "content2")
vcs.update_file_in_version("file1.txt", "new_content1")
vcs.delete_file_from_version("file2.txt")
print(vcs.get_version_history())
print(vcs.get_file_from_version("file1.txt"))