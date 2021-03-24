use crate::client::Task;
use serde::Deserialize;
use std::{thread, time};

pub struct Prover {}

// TODO: use bell_man
#[derive(Debug, Deserialize, Clone, PartialEq)]
pub struct Proof {}

impl Default for Prover {
    fn default() -> Self {
        Self::new()
    }
}

impl Prover {
    pub fn new() -> Self {
        Self {}
    }

    pub async fn prove(&self, _task: Task) -> Result<Proof, anyhow::Error> {
        let ten_millis = time::Duration::from_millis(10000);
        thread::sleep(ten_millis);
        Ok(Proof {})
    }
}
