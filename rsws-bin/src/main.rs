use idgenerator::*;

fn main() {
    let mut options =  IdGeneratorOptions::new().worker_id(1).worker_id_bit_len(6);
    let _ = IdInstance::init(options);
    let id = IdInstance::next_id();
}
