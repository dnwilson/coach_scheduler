const EmptyState = ({children}) => {
  return(
    <div className="empty-state">
      <div className="empty-state-title">Nothing to display</div>
      { children }
    </div>
  )
}

const List = ({ title, items, children }) => {
  return(
    <section id="slots">
      <h4 className="section-title">{title}</h4>
      <div className="slots">
        { items?.length > 0
          ? items
          : <EmptyState children={children} />
        }
      </div>
    </section>
  )
}

export default List;