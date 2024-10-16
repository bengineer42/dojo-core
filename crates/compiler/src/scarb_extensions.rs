use anyhow::Result;
use camino::Utf8Path;
use scarb::{core::Workspace, flock::Filesystem};

use crate::{MANIFESTS_BASE_DIR, MANIFESTS_DIR};

/// Handy enum for selecting the current profile or all profiles.
#[derive(Debug)]
pub enum ProfileSpec {
    WorkspaceCurrent,
    All,
}

/// Extension trait for the [`Filesystem`] type.
pub trait FilesystemExt {
    /// Returns a new Filesystem with the given subdirectories.
    ///
    /// This is a helper function since flock [`Filesystem`] only has a child method.
    fn children(&self, sub_dirs: &[impl AsRef<Utf8Path>]) -> Filesystem;

    /// Lists all the files in the filesystem root, not recursively.
    fn list_files(&self) -> Result<Vec<String>>;
}

impl FilesystemExt for Filesystem {
    fn children(&self, sub_dirs: &[impl AsRef<Utf8Path>]) -> Self {
        if sub_dirs.is_empty() {
            return self.clone();
        }

        let mut result = self.clone();

        for sub_dir in sub_dirs {
            result = result.child(sub_dir);
        }

        result
    }

    fn list_files(&self) -> Result<Vec<String>> {
        let mut files = Vec::new();

        let path = self.to_string();

        for entry in std::fs::read_dir(path)? {
            let entry = entry?;
            if entry.file_type()?.is_file() {
                files.push(entry.file_name().to_string_lossy().to_string());
            }
        }

        Ok(files)
    }
}

/// Extension trait for the [`Workspace`] type.
pub trait WorkspaceExt {
    /// Returns the target directory for the current profile.
    fn target_dir_profile(&self) -> Filesystem;
    /// Returns the manifests directory for the current profile.
    fn dojo_base_manfiests_dir_profile(&self) -> Filesystem;
    /// Returns the base manifests directory.
    fn dojo_manifests_dir(&self) -> Filesystem;
    /// Returns the manifests directory for the current profile.
    fn dojo_manifests_dir_profile(&self) -> Filesystem;
    /// Checks if the current profile is valid for the workspace.
    fn profile_check(&self) -> Result<()>;
}

impl WorkspaceExt for Workspace<'_> {
    fn target_dir_profile(&self) -> Filesystem {
        self.target_dir().child(
            self.current_profile()
                .expect("Current profile always exists")
                .as_str(),
        )
    }

    fn dojo_base_manfiests_dir_profile(&self) -> Filesystem {
        let manifests_dir = self.dojo_manifests_dir();

        manifests_dir.children(&[
            self.current_profile()
                .expect("Current profile always exists")
                .as_str(),
            MANIFESTS_BASE_DIR,
        ])
    }

    fn dojo_manifests_dir(&self) -> Filesystem {
        let base_dir = self.manifest_path().parent().unwrap();
        Filesystem::new(base_dir.to_path_buf()).child(MANIFESTS_DIR)
    }

    fn dojo_manifests_dir_profile(&self) -> Filesystem {
        let manifests_dir = self.dojo_manifests_dir();

        manifests_dir.child(
            self.current_profile()
                .expect("Current profile always exists")
                .as_str(),
        )
    }

    fn profile_check(&self) -> Result<()> {
        if let Err(e) = self.current_profile() {
            if e.to_string().contains("has no profile") {
                // Extract the profile name from the error message
                if let Some(profile_name) = e.to_string().split('`').nth(3) {
                    anyhow::bail!("Profile '{}' not found in workspace. Consider adding [profile.{}] to your Scarb.toml to declare the profile.", profile_name, profile_name);
                }
            }
            anyhow::bail!("Profile check failed: {}", e);
        }

        Ok(())
    }
}
