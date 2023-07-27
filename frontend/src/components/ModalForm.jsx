import Modal from "./Modal";

const ModalForm = ({title, show, toggle, children}) => {
  return(
    <>
      <button onClick={toggle} className="button mb-0">Add {title}</button>
      <Modal toggle={toggle} show={show} title={`Add ${title}`}>
        { children }
      </Modal>
    </>
  )
}

export default ModalForm