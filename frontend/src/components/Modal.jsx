import "./Modal.css"

const Modal = ({show, toggle, title, children}) => {
  return(
    <div className={`modal ${show ? 'modal-show' : ''}`}>
      <div className="modal-backdrop" onClick={toggle}></div>
      <div className="modal-dialog">
        <div className="modal-header">
          {
            title && <h4 className="mb-0">{title}</h4>
          }
        </div>
        <div className="backdrop"></div>
        <div className="modal-body">{children}</div>
      </div>
    </div>
  )
}

export default Modal;